*** Settings ***
Library    RPA.Browser.Selenium
Library    String
Library    RPA.Notifier
Library    compareString.py
Library    RPA.Robocorp.Vault

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
    FOR    ${element}    IN    @{list}
        IF    ${next} == ${True}
            ${parkingCode}    Set Variable    ${element}
            Exit For Loop
        END
        ${match}    Compare Strings    ${element}    koodi
        IF    ${match} == ${True}
            ${next}    Set Variable    ${True}
        END
    END
    [Return]    ${parkingCode}
Send parking code via Twilio
    [Arguments]    ${parkingCode}
    ${twilio}    Get Secret    Twilio
    Notify Twilio    message=${parkingCode}    number_from=${twilio}[phone_from]    number_to=${twilio}[phone_to]    account_sid=${twilio}[account_sid]    token=${twilio}[token]
    
    