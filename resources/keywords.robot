*** Settings ***
Library    RPA.Browser.Selenium
Library    String

*** Keywords ***
Open Seurahuone parking site
    Open Available Browser    https://www.sokoshotels.fi/fi/turku/sokos-hotel-seurahuone/pysakointi    headless=${True}
    Wait Until Page Contains Element    id:p_p_id_feature_WAR_sokoshotelsportlets_
Find parking code
    ${parkingCode}    Set Variable
    ${next}    Set Variable    ${False}
    ${match}    Set Variable    ${False}
    ${pageContent}    Get Text    xpath://div[@class="feature__description"]
    @{list}    Split String    ${pageContent}
    Set Log Level    none
    FOR    ${element}    IN    @{list}
        IF    ${next} == ${True}
            ${parkingCode}    Set Variable    ${element}
            Exit For Loop
        END
        ${match}    Set Variable If    ${element} == koodi ${True}
        IF    ${match} == ${True}
            ${next}    Set Variable    ${True}
        END
    END
    Set Log Level    info
    Log    ${parkingCode}