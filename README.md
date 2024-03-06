# FrostyLibrary
FrostyLibrary is a Snowflake demo using: Streamlit, Cortex LLM (summarize) and External UDF Access. Setup in less than 5 minutes! The demo is composed by 3 steps:
- Import Books from internet: open the import tab, write the URL of your book in txt format and categorize your book with author and title)
- Create book summary using Cortex LLM SUMMARIZE() function: once the book is imported in your library, move to the second panel to generate the summary (it might take a few minutes with an XS WH)
- Archive the summary in your archive to access them any time: once the book is summarized, it will be automatically archived on table "frosty_library_archive_summary_table". The summaries will be accessible anytime from the streamlit app without re-running the summarization function.

![alt text](https://github.com/matteo-consoli/frostylibrary/blob/main/screenshot.png?raw=true)

### FrostyLibrary Deployment
1) Run the setup.sql in a Snowsight worksheet.
2) Download "frostylibrary_sis.py" and "logo_frostylibrary.png" from the GitHub repository.
3) Create a new Streamlit app on your Snowflake account (config screenshot below)
4) Paste the code into your new app.
5) Upload the "logo.png" in the Streamlit application stage.

![alt text](https://github.com/matteo-consoli/frostylibrary/blob/main/screenshot_setup_streamlit.png?raw=true)

NOTE: FrostyLibrary is not intended to be a ready-to-use artifact but it merely provides a foundation on available features in Snowflake. Have fun!
