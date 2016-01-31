# The API the IRS Should Have Built

[www.charityapi.org](www.charityapi.org)

Heroku (while DNS propagates): [charityapi.herokuapp.com](charityapi.herokuapp.com)

[![Build Status](https://semaphoreci.com/api/v1/projects/2df1d7f1-851a-474b-ac1b-dac48adf54b1/679889/badge.svg)](https://semaphoreci.com/grantmnelson/charityapi)

Grant runs a small nonprofit that has to verify that other nonprofits they work with are actually nonprofit (IRS Section 170 / deductible). The IRS provides search tools, but they require 3 different searches and ~16% of the time a phone call to the IRS to ascertain whether another food bank or food pantry is actually a nonprofit. By the way, the IRS will only let you ask about one EIN at a time despite the typically 45-minute wait.

So, this weekend we took the data that the IRS publishes (somewhat) regularly and put it in an API format available at charityapi.org.

Laila analyzed, sorted, and developed the taxonomy structure of the IRS's data, finding several sources of data on the IRS website. She also wrote the clear and helpful documentation.

Yusuf, a ruby developer, setup the database architecture and wrote nearly all of the unit tests and validations. 

Other organizations providing this service range from free and not a high priority for the organization (pro publica) or thousands of dollars per year for API access.

This tool will continue to be maintained and improved by Grant and his team at the MEANS Database ([www.foodrecovery.org](www.foodrecovery.org)), a nonprofit that helps connect those with surplus food to those that need it.

### [View the Docs](https://hoyahacks2016.slack.com/messages/charity-api/)
Want to contribute to the doc? Click [here](https://github.com/Grantimus9/charityapidoc)

