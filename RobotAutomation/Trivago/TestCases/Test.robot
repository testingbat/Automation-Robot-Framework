*** Settings ***
Documentation       This test suite covers the following test scenarios for trivago magazine (https://magazine.trivago.com/):
...                 1. Search for “Texas” using the search functionality
...                     a. Verify that the displayed number of search results is correct
...                 2. From the displayed results open “Mom Knows Best: Family Vacations in Texas”
...                     a. Verify that the list of “Featured hotels and resorts” displays all hotels featured in the article,
...                     b. Verify that there are no broken links in the article
Library     SeleniumLibrary
Resource        ../Resources/keywords.robot

*** Test Cases ***
Verify user navigates correctly to Trivago magazine site
    Given user navigates to trivago magazine website
    And user maximises the browser
    Then trivago magazine page title should match

Verify search functionality and results
    Given user clicks on search icon
    And search box is visible
    And search box is enabled
    And user clears the search box
    And user searches for location	#texas
    Then search results are displayed without error
    And number of search results in title match the number of results on the page
    And all search results contain the search keyword or synonyms

Verify user is able to open Mom Knows Best link
    Given user clicks on Mom Knows Best link
    Then the Mom Knows Best article page title should match

Verify Featured hotels contains all hotels in the article
    Given user is on Mom Knows Best page
    Then list of Featured hotels and resorts displays all hotels featured in the article

Verify there are no broken links Mom Knows Best page
    Given user is on Mom Knows Best page
    Then verify that there are no broken links in the article