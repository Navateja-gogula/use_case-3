pipeline {
    agent any

    environment {
        LOCAL_SERVER = 'tcp:10.128.0.16,1433'
        REMOTE_SERVER = '34.170.77.150'
        LOCAL_DB = 'aspnet_DB'
        REMOTE_DB = 'aspnet_DB'
        LOCAL_TABLE = 'asp_user'
        REMOTE_TABLE = 'asp_user'
        SA_USER = 'sa'
        SA_PASS = 'P@ssword@123'      // store P@ssword@123 securely
    }

    stages {
        stage('Checkout Code') {
            steps {
                git url: 'https://github.com/Navateja-gogula/use_case-3.git', branch: 'main'
            }
        }

        stage('Run PowerShell Script') {
            steps {
                powershell """
                    ./Copy-Data.ps1 `
                        -LocalServer "$env:LOCAL_SERVER" `
                        -RemoteServer "$env:REMOTE_SERVER" `
                        -LocalDB "$env:LOCAL_DB" `
                        -RemoteDB "$env:REMOTE_DB" `
                        -LocalTable "$env:LOCAL_TABLE" `
                        -RemoteTable "$env:REMOTE_TABLE" `
                        -User "$env:SA_USER" `
                        -Password "$env:SA_PASS"
                """
            }
        }
    }
}
