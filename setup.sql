-- Execute the code below as-is in a Snowsight worksheet.
-- Create objects (for simplicity, in this demo we'll use accountadmin role)

CREATE DATABASE IF NOT EXISTS FROSTYLIBRARY;
CREATE SCHEMA IF NOT EXISTS FROSTYLIBRARY.HOL_LLM;
USE SCHEMA FROSTYLIBRARY.HOL_LLM;
CREATE WAREHOUSE IF NOT EXISTS FROSTYLIBRARY_WH
    WAREHOUSE_SIZE = 'XSmall' 
    AUTO_SUSPEND=60 
    AUTO_RESUME=True;

-- Table creating (staging and archive)
CREATE OR REPLACE TABLE frosty_library (
   books_output VARIANT
);
CREATE TABLE frosty_library_archive_summary_table (
    book_url VARCHAR,
    book_summary VARCHAR,
    book_author VARCHAR,
    book_title VARCHAR,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP()
);

-- Create function to import books from internet - in the example below we use gutenberg.org)
CREATE OR REPLACE NETWORK RULE network_get_book MODE = EGRESS TYPE = HOST_PORT VALUE_LIST = ('www.gutenberg.org');

CREATE OR REPLACE EXTERNAL ACCESS INTEGRATION integration_get_book
        ALLOWED_NETWORK_RULES = (network_get_book)
        ALLOWED_AUTHENTICATION_SECRETS = ()
        ENABLED = TRUE;

CREATE OR REPLACE FUNCTION import_book(parameter STRING, book_title STRING, book_author STRING)
  RETURNS VARIANT
  LANGUAGE PYTHON
  RUNTIME_VERSION = 3.10
  HANDLER = 'API_get_book'
  EXTERNAL_ACCESS_INTEGRATIONS = (integration_get_book)
  PACKAGES = ('snowflake-snowpark-python', 'requests')
  AS
$$
import requests

def API_get_book(url, book_title, book_author):  
    try:
        url
    except NameError:
        url = ''

    apiURL = '{param}'.format(param=url)
    response = requests.get(apiURL)
    if response.status_code == 200:
        content = response.content.decode('utf-8')
        chunks = [content[i:i+16384] for i in range(0, len(content), 16384)]
        return [{'book_title': book_title, 'book_author': book_author,  'url': url, 'sequence': i + 1, 'content': chunk} for i, chunk in enumerate(chunks)]
    else:
        return [{'error': apiURL + ' Error Code: ' + str(response.status_code) + ' Message: ' + response.text}]
$$;

-- Create View exposing flattened data from the staging folder.
CREATE OR REPLACE VIEW frosty_library_flattened AS  
SELECT 
f.value:book_title as book_title,
f.value:book_author as book_author,
f.value:url as url_book_id,
f.value:sequence as content_sequence,
f.value:content as content
FROM
    frosty_library,
   lateral flatten(input => books_output, path => '') f;
