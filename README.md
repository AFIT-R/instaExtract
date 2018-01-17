instaExtract Readme
================
Anthony Kallhoff
17 January 2018

instaExtract
------------

Goal
====

The instaExtract package aims to provide analysts a method for pulling information from Instagram and a foundation for future analytic function to be created and shared.

Features
========

Chief among instaExtract's functionality is providing the tools for the user to pull relevant data from Instagram. This is accomplished by pulling information from JSON links constructed based on the user's query. These queries may be based on a user, a location, a particular post, or a hashtag. The package then returns a dataframe with the information relating to either the selected item or a number of items. These returned values depend on what item is being created, but contain such things as the username, date, number of likes, relevant hashtags, and a permanent link. These fields form a foundation for analysts to discover trends and patterns relating to their field of study. For example, an intel officer might find that an inoccous hashtag is highly correlated with known members of an orginzation.

While the goal is for this package to be updated and accumulate useful functions as they are developed in the real world, the package starts only as a tool to pull information. Therefor, the end-user does not require much to any skill. Simply knowing what they are looking for is all that is required. In creating a shiny app, creating an interface that illustrates what capacity for searching the package will do will further reduce the complexity of the package.

This package relies on quite a few other packages: Imports: rvest, RSelenium, wdman, tidyverse, jsonlite, plyr, bit64, rlist, httr Depends: dplyr

Time Table
----------

| Feature           | Priority | Status      | Value                                                                           | Input                                        | Output                                                         | Usage                                                                                | Time to Create                                         | Current/Pushed?                                               |
|:------------------|:---------|:------------|:--------------------------------------------------------------------------------|:---------------------------------------------|:---------------------------------------------------------------|:-------------------------------------------------------------------------------------|:-------------------------------------------------------|:--------------------------------------------------------------|
| General Searching | 1        | finished    | Allow a user to search Instagram for the data relating to a search              | A query: a hashtag, location, username, etc. | A dataframe with relevant information                          | Output will be analyzed with other tools to uncover trends                           | NA                                                     | Current                                                       |
| Error Checking    | 3        | in-work     | Report errors, stop faulty functioning code                                     | NA                                           | A console message                                              | Keep user informed, and program working                                              | Not feasible before release                            | Pushed                                                        |
| Location Mapping  | 2        | in-work     | A contenxual organization of media allowing analysts insight into their origins | The region wishing to be populated           | A dataframe with all location codes readily given by Instagram | Use the location codes to search with a radius of a given lat long to find new posts | A few more hours, feasible                             | Want to be with current version, to show potential of package |
| Authentication    | 3        | not started | Allow users to access information blocked for unauthorized users                | Log in credentials                           | Headers to add to JSON links                                   | Can collect further information, such as who is following a certain user             | Could concievable be added if things progress smoothly | Most likely will be pushed                                    |
