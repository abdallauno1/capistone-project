pipeline{
    agent {label 'vagrant-worker'}
    environment{
      DOCKERHUB_CREDENTIALS = credentials('abdallauno1-dockerhub')
    }
    stages{

        stage("Build Image"){
          /* build docker image  */
            steps{
                sh 'docker build -t abdallauno1/perscholas:v1 .'
            }            
        }
        stage("Login to DockerHub"){
          /* login in dockerhub  */
            steps{
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }            
        }
        stage("Push image DockerHub"){
          /* push docker image to dockerhub */
            steps{
                sh 'docker push abdallauno1/perscholas:v1'
            }            
        }
	    
	    
        stage("Create directory and Copy files"){
	        steps{   
			
		  sh '''
			 set +x				    			  
			 rm -rf ~/terraform/
			 mkdir ~/terraform/	
			 cp -r install.sh main.tf variable.tf /home/vagrant/terraform
			
	              '''
			
			
            }        
        }
	    
        stage('Check if terraform installed'){
	        steps{
		    script{
			    def terraformOK  = fileExists '/usr/bin/terraform'
			    if (terraformOK) {
				echo 'Skipping install terraform...terraform already installed'
			}else{
				sh '''#!/bin/bash
				sudo apt-get install -y gnupg software-properties-common curl
				curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
				sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
				sudo apt-get update && sudo apt-get install terraform
			 '''	
					 }
		       }
		   }
	    }
	    

       	stage('Terrafrom init'){
		    steps{
				
		      sh '''
			    set +x
			    cd ~/terraform/				  
			    terraform init 
			 '''
		  }
         }
	    
       stage('Terrafrom fmt'){
		    steps{
				
		      sh '''
			    set +x
			    echo terraform format 
			    cd ~/terraform/				  
			    terraform fmt 
			    
			 '''
	  	}
   }
	    
        stage('Terrafrom validate'){
		    steps{
				
		      sh '''
			    set +x
			    echo terraform validate 
			    cd ~/terraform/				  
			    terraform validate 
			 '''
		  }
        }
	    
        stage('Terrafrom paln'){
		    steps{
				
		      sh '''
			    echo terraform plan 
			    set +x
			    cd ~/terraform/				  
			    terraform plan 
			 '''
		  }
        }
	    
        stage('Terrafrom apply'){
		    steps{
				
		      sh '''
			    set +x
			    echo terraform Apply 
			    cd ~/terraform/				  
			    terraform apply --auto-approve 
			 '''
		  }
      	    }
     	}
	
    post{
        always{
            sh "docker logout"
        }
        success{
            echo "========pipeline executed successfully ========"
        }
        failure{
            echo "========pipeline execution failed========"
        }
    }
}