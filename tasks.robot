*** Settings ***
Documentation       Template robot main suite.
Resource    resources/keywords.robot


*** Tasks ***
Find parking code for Seurahuone and send it.
    Open Seurahuone parking site
    ${parkingCode}    Find parking code
    Send parking code via Twilio    ${parkingCode}