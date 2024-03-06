# FrostyLibrary
FrostyLibrary is a Snowflake demo using: Streamlit, Cortex LLM (summarize) and External UDF Access. Setup in less than 5 minutes! 
Import Books from internet, create book summary using Cortex LLM SUMMARIZE() function, archive the summary in your archive to access them any time! 

![alt text](https://github.com/matteo-consoli/frostylibrary/blob/main/screenshot.png?raw=true)

### FrostyLibrary Deployment
1) Run the setup.sql in a Snowsight worksheet.
1) Download "frostytracking_sis.py" and "logo_frostylibrary.png" from the GitHub repository.
2) Create a new Streamlit app on your Snowflake account
3) Paste the code into your new app.
4) Upload the "logo.png" in the Streamlit application stage.

Step 2 Screenshot:
![alt text](https://github.com/matteo-consoli/frostylibrary/blob/main/screenshot_setup_streamlit.png?raw=true)

NOTE: FrostyLibrary is not intended to be a ready-to-use artifact but it merely provides a foundation on available features in Snowflake. Have fun!
