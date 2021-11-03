*** Settings ***
Documentation       Suite description
Library     SeleniumLibrary
Library     Collections
Library     String
Library     RequestsLibrary
Variables       ../PageObjects/locators.py

*** Variables ***
${SiteUrl}      https://magazine.trivago.com
${Browser}      chrome
${main_page_title}      trivago Magazine
${momknows_page_title}      Mom Knows Best: 10 Family Vacations in Texas to Inspire Your Next Trip

*** Keywords ***

user navigates to trivago magazine website
    #open with specified URL and browser
    open browser    ${SiteUrl}      ${Browser}

user maximises the browser
    #maximise the window
    maximize browser window
    #wait for 5 seconds
    sleep       5 seconds

trivago magazine page title should match
    #verify title of the page
    title should be     ${main_page_title}

user clicks on search icon
    #click on search icon
    click element       ${search_icon}
    sleep       5 seconds

search box is visible
    #verify that the search box is visible
    element should be visible       ${search_field}

search box is enabled
    #verify that the search box is enabled
    element should be enabled       ${search_field}

user clears the search box
    #clear the search box
    clear element text      ${search_field}

user searches for location	#texas
    #input search text as 'texas' in the search box
    input text      ${search_field}      texas
    #press enter
    press key       ${search_field}     \\13
    sleep       15 seconds

search results are displayed without error
    sleep       5 seconds
    #get search results headers
    ${search_result}=      get text        ${header3}
    #verify that header string does not display no results
    should not be equal as strings      No results      ${search_result}

number of search results in title match the number of results on the page
    #code to extract no. of search results
    ${search_result}=      get text        ${header3}
    #splitting the search results header to get the number of results
    @{search_results_header}=        split string        ${search_result}      ${SPACE}
    #log no. of search results displayed in header
    log to console      ${search_results_header}[0]
    #get count of the no. of search results displayed on the page
    ${search_results_page_count}=        get element count       ${search_results_page}
    #verify if the no. of search results displayed in the header and the page are equal
    should be equal as strings      ${search_results_header}[0]     ${search_results_page_count}

all search results contain the search keyword or synonyms
    #get the count of search results on the page
    ${search_results_page_count}=        get element count       ${search_results_page}
    #loop through the search results
    FOR       ${i}        IN RANGE        1       ${search_results_page_count}+1
        #get text of each search result on the page
        ${linkText}=        get text      xpath://header/div[1]/div[1]/div[4]/div[1]/div[8]/section[1]/div[1]/div[${i}]/a[1]
        #log search result text
        log to console      ${linkText}
        #verify that each search result contains atleast one of the keywords - Texas|SOUTHWEST|Houston
        should match regexp     ${linkText}     Texas|SOUTHWEST|Houston
    END

user clicks on Mom Knows Best link
    #click on mom knows best link
    click element       ${momknows_article_link}
    sleep       30 seconds
    #scroll down
    execute javascript      window.scrollTo(0,3000)

the Mom Knows Best article page title should match
    #verify title of mom knows best page
    title should be     ${momknows_page_title}
    #add specific element wait method
    sleep       15 seconds
    click element       ${close_popup}
    #add condition to wait for #REMOVE

user is on Mom Knows Best page
    #get header of the page
    ${mom_page_title}      get text        ${header1}
    #verify header is displayed as expected
    should be equal as strings       ${mom_page_title}       ${momknows_page_title}

list of Featured hotels and resorts displays all hotels featured in the article
    ${HotelLinksCount}=        get element count       ${featured_hotels}

    ${ArticleHotels_list}=     create list
    log to console      ******Article Hotels*******
    FOR       ${i}        IN RANGE        6        16
        #looping through the articles hotels to get all article hotel names
        ${ArticleHotels}=        get text      xpath://div[${i}]/div[1]/div[1]/div[2]/div[2]/div[1]/div[1]/div[1]/div[1]/div[1]/h3[1]/span[1]
        log to console      ${ArticleHotels}
        #add hotel names to article hotels list
        append to list      ${ArticleHotels_list}      ${ArticleHotels}
    END

    ${featuredHotels_list}=     create list
    log to console      ******Featured Hotels*******
    FOR       ${i}        IN RANGE        1        ${HotelLinksCount}+1
        #looping through the featured hotels list to get all featured hotel names
        ${featuredHotels}=        get text      xpath:/html[1]/body[1]/div[1]/div[1]/div[1]/div[1]/div[3]/article[1]/div[1]/div[2]/div[1]/div[3]/div[1]/ol[1]/li[${i}]/div[1]
        log to console      ${featuredHotels}
        #add hotel names to featured hotels list
        append to list      ${featuredHotels_list}      ${featuredHotels}
    END

    #get count of featured hotels count
    ${featuredHotels_list_count}=      get length      ${featuredHotels_list}
    #get count of hotels in article
    ${ArticleHotels_list_count}=      get length      ${ArticleHotels_list}
    #verify that the count of featured hotels matches with the count of hotels listed in the article
    should be equal    ${featuredHotels_list_count}      ${ArticleHotels_list_count}

    #code to verify that list of Featured hotels and resorts displays all hotels featured in the article
    FOR       ${i}        IN RANGE        0        ${HotelLinksCount}
        #get featured hotel name from list
        ${featured}=       get from list       ${featuredHotels_list}      ${i}
        #code to remove the last 3 characters from featured hotel as some names contain period
        ${featuredHotel}=        replace string      ${featured}        .     ${EMPTY}        count=3
        #get article hotel name from list
        ${ArticleHotel}=       get from list       ${ArticleHotels_list}       ${i}
        log to console      featuredHotels_stripped=${featuredHotel}
        #verify article hotel and featured hotel are same
        should contain   ${ArticleHotel}        ${featuredHotel}
    END

verify that there are no broken links in the article
    #get count of all links in the page
    ${AllLinksCount}=   get element count       ${all_links}
    log to console      AllLinksCount=${AllLinksCount}

    @{LinkItems}        create list

    FOR     ${i}        IN RANGE        1       ${AllLinksCount}
        log to console      index=${i}
        #get all href in site
        ${href}=        get element attribute       xpath:(//a)[${i}]       href
        log to console      ${href}
        #get link length
        ${checklinklength}=     get length      ${href}
        #check if link starts with http
        ${checkStartsWith}=     run keyword and ignore error      should start with       ${href}     http
        log to console      checkStartsWith=${checkStartsWith}
        #add link to list only if length is more than 1 and starts with http
        IF      ${checklinklength}>1 and '${checkStartsWith}[0]'=='PASS'
        append to list      ${LinkItems}        ${href}
        END
    END

    #remove duplicate links from list
    remove duplicates       ${LinkItems}
    #log list of all links
    log to console      ${LinkItems}
    #get length of the link items in the list
    ${LinkItems_length}=     get length      ${LinkItems}
    log to console      LinkItems_length=${LinkItems_length}

    #create list to add potential broken links
    @{BrokenLinks}        create list

    #loop through each item of the list to verify response status code
    FOR     ${i}        IN RANGE        ${LinkItems_length}
        log to console      ${i}
        create session      web-session        ${LinkItems[${i}]}
        ${response}=     get request     web-session        /
        #checks all links and adds the status code result for each link
        ${result}=      Run Keyword And Return Status       should be equal as strings      ${response.status_code}     200
        log to console      Link=${LinkItems[${i}]}
        log to console      Response_Code=${response.status_code}
        log to console      Result=${result}
        #if status code is not 200, then add the link to Broken Links list
        IF      ${response.status_code}!=200
        append to list      ${BrokenLinks}        ${LinkItems[${i}]}
        END
    END
    #log all items in the Broken Links list
    log to console      Potential_BrokenLinks=${BrokenLinks}

    close browser
