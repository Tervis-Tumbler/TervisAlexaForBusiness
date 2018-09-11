function Invoke-AlexaForBusinessSetup {
    Start-Process https://s3.amazonaws.com/device-setup-tool/setup.exe
}

function Invoke-AlexaForBusinessServiceAccountSetup {
    #https://docs.aws.amazon.com/a4b/latest/ag/office.html
    #The below was not used, see evernote:///view/191267472/s270/dfedf2f3-fe5f-40b0-b259-2aeba183b1bb/dfedf2f3-fe5f-40b0-b259-2aeba183b1bb/4ae28e51-177c-4650-8663-8f444a5926e9
    $OU = Get-TervisADOrganizationalUnitThatholdsServiceAccounts
    #Import-TervisOffice365ExchangePSSession
    $InExchangeOnlinePowerShellModuleShell = Connect-EXOPSSessionWithinExchangeOnlineShell
    if ($InExchangeOnlinePowerShellModuleShell) {
        New-Mailbox -UserPrincipalName "alexaforbusiness@tervis.com" -Alias "AlexaforBusiness" -Name alexaforbusiness -OrganizationalUnit $OU.DistinguishedName -FirstName Alexa -LastName "For Business Service Account" -DisplayName "Alexa for Business Service Account"
        Get-Mailbox -ResultSize unlimited -RecipientTypeDetails "RoomMailbox" | Set-CalendarProcessing -DeleteComments $FALSE    
    } else {m
        Throw "Either run this from an Exchange online managment shell or refactor the code to support O365 version commandlets"
    }
}