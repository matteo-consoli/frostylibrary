# FrostyLibrary
FrostyLibrary is a demo built using mainly three Snowflake features: Streamlit, Cortex LLM Functions, and UDF with external network access. 
The FrostyLibrary UI is composed of just 3 tabs that guide users through the end-to-end process of importing books in a staging area (table) up to archiving summaries in a final structure.
- **Import Books from internet:** Select the "Import Book" tab. Importing a book into FrostyLibrary is going to be as simple as writing the URL of your text/book (txt format) and categorizing your book with author and title _(i.e. URL: https://www.gutenberg.org/cache/epub/174/pg174.txt , Author: Oscar Wilde , Book Title: The Picture of Dorian Gray)_ .
Under the hood, the procedure invokes a UDF function that imports the book in a staging table (in a VARIANT column), splitting it into small chunks.
- **Generate Book Summary using Cortex LLM SUMMARIZE() function:** Once the book is imported into your library, move to the second tab to generate the summary (it might take a few minutes with an Extra Small Virtual Warehouse). The engine is within the Streamlit app. The function summarize_flattened_view (check the code in the frostylibrary_sis.py file) summarizes the n chunks of the selected book (previously imported) one by one, then does a final summarization across the n partial summaries generated. Once summarized, the function stores the results in an archive table: frosty_library_archive_summary_table.
- **Get Book Summary From Archive:** From your archive, you can access generated book summaries at any time without re-running the summarize() function.

![alt text](https://github.com/matteo-consoli/frostylibrary/blob/main/screenshot.png?raw=true)

### FrostyLibrary Deployment
You can deploy FrostyTracking in your Snowflake account and customize this project in your environment by following these 5 steps.
1) Download the frostylibrary_sis.py and logo_frostylibrary.png and setup.sqlfiles from the GitHub Repository.
2) Run the setup.sql in a Snowsight worksheet.
3) Create a new Streamlit app within your Snowflake account via Snowsight -> "Projects" -> "Streamlit" -> "+ Streamlit App" (define the WH to be used, location, and your application name).
4) Paste the code from the frostylibrary_sis.py file into your new Streamlit app and import the plotly package from the "Packages" menu.
5) Optional: Upload the logo_frostylibrary.png image to the Streamlit application stage in Snowflake (recommended to make it fancy!)

FrostyLibrary - Upload images to SiS Stage

![alt text](https://github.com/matteo-consoli/frostylibrary/blob/main/screenshot_setup_streamlit.png?raw=true)

NOTE: FrostyLibrary is not intended to be a production-ready artifact.
