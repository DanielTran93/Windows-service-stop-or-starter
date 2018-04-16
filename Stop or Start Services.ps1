#Stop / Start script. Place the services you wish to have stopped in the services.txt file.
#author Daniel Tran 2018

#gets the service.txt file in the same diretory as this script, splits it into rows
$services = (Get-Content -path "services.txt") -split','


Foreach ($service in $services)
{
    #checks if the service is running or stopped to see if it actually exists. if not it exits.
    If ((Get-Service $service).Status -eq 'Running' -Or (Get-Service $service).Status -eq 'Stopped')
    {
        Write-Host $service is valid
        

    }
    
    #If service does not exist, this message box is shown.
    else {
        Write-Host $service does not exist. Please check your service name in services.txt
        Read-Host "Press enter to exit"     
        exit
    }
}

#brings out the type box, sets the $command to what ever you typed into the box and places it into lower characters

$command = (Read-Host 'Do you want to "Start" or "Stop" Services?').ToLower()

#checks if the typed command is stop
if ($command -eq 'stop')

{
    #checks each line in the services.txt file for service, sets service to manual and then stops. if it is SSO service, forces it to stop.
	Foreach ($service in $services)	
		{
            
            if ($service -eq "ENTSSO")
            {
                    Write-host $service "is stopping"
            		set-service $service -startupType Manual
			        stop-service $service -force
            }
            
            
            else {
			Write-host $service "is stopping"
			set-service $service -startupType Manual
			stop-service $service
            
            }
            
            
		}
        #tells us the services has been stopped (all the ones which exist)
        Write-Host 'Applicable services have been stopped'
        Read-Host "Press enter to exit"
        exit
    

}

    #checks if command is start, checks each service. sets to automatic and starts
	Elseif ($command -eq 'start')
		{
			Foreach ($service in $services)
				{
					Write-Host $service "is starting"
					set-service $service -startupType Automatic
					start-service $service
    
		}
		
        #any services which exists in the text file would have started
            Write-Host 'Applicable services have been started'
            Read-Host "Press enter to exit"
            exit
       
        		
		}

#if the $command is not any of the start or stop, brings out the below message box.
	Elseif ($command -ne "start" -Or "stop")
{
    Write-Host $command is invalid. Please type start or stop next time.
    Read-Host "Press enter to exit"
    exit
   
}



