# README
#
#### Introduction
Our team is creating an application for TAMU Wakeboarding. The goal of this application is to automate the everyday tasks of the leadership team and the members. 

This application will keep track of all the members and their roles within the organization. It will give selective access to specific parts of the application based on the role of the member. 

This application serves four main users - admin, treasurer, drivers, and riders. 

The riders (every member of the organization) are only allowed to sign up for sets. 

The drivers, in addition to rider privileges, are allowed to create sets and submit receipts to the treasurer. They are also able to view all their receipts whether they have been processed, are being processed, or still need to be processed. 

The treasurer in addition to having rider privileges is able to view all the submitted receipts and accept or deny them based on the information shared by the driver. 

The admin has access to the entire application and can add and modify all other user's privileges.

## Requirements ##

This code has been run and tested using the following internal and external components

Environment
•	Debian GNU/Linux 11 (bullseye)
•	Docker Engine v20.10.22
•	Docker container - paulinewade/csce431:latest
•	HerokuCLI v8.0.5

Program
•	Ruby v3.1.2
•	Rails 7.0.4.2
•	Rspec-rails 6.0.1
•   rubocop-capybara 2.17.1
•   selenium-webdriver 4.8.0
•	PostgreSQL v?
•	Tailwind 2.0.25 
•   Devise v4.8.1
•   Capybara 3.38.0
•   Omniauth v2.1.1
•   Omniauth-google-oauth2 v1.1.1
•   Pagy v6.0.3
•   Font-awesome-sass 6.4.0

Tools
•	Git Hub - [main branch](https://github.com/texasnathan01/TAMUWake)
•	RuboCop 1.45.1
•   rubocop-performance 1.16.0 
•   rubocop-rails 2.17.4   
•   rubocop-rspec 2.18.1
•	Simplecov 0.22.0
•	Brakeman 5.4.0
•	Jira 7.7.4
•	VS Code 5.0.2

## External Deps

- Docker - Download latest version at https://www.docker.com/products/docker-desktop
- Heroku CLI - Download latest version at https://devcenter.heroku.com/articles/heroku-cli
- Git - Downloat latest version at https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
- GitHub Desktop (Not needed, but HELPFUL) at https://desktop.github.com/

## Documentation

Our product and sprint backlog can be found in Jira, with organization name team-team and project name Team Team

Document
•	Data Design v3
•	UX Design v3
•	User’s Manual v3

Data
•	Test Data v1


## Installation ##

Download this code repository by using git:

 `git clone https://github.com/texasnathan01/TAMUWake.git`


## Tests ##

An RSpec test suite is available and can be ran using:

  `rspec spec/`

in your terminal. You can run this in windows powershell
or a unix terminal. Make sure you run this while in the provided docker container.

## Execute Code ##

Run the following code in Powershell if using windows or the terminal using Linux/Mac

  `cd {directory_where_app_is_located}`

  `docker run --rm -it --volume "$(pwd):/rails_app" -e DATABASE_USER=test_app -e DATABASE_PASSWORD=test_password -p 3000:3000 paulinewade/csce431:latest`

  `cd tamuwake`

Install the app

  `bundle install && rails db:create && db:migrate && rails db:seed`


Running the app
  
  For Windows
    `rails tailwindcss:watch &`
    `rails server --binding:0.0.0.0`

  For Mac
  `./bin/dev`

The application can be seen using a browser and navigating to http://localhost:3000/

## Environmental Variables/Files ##

Google OAuth2 support requires two keys to function as intended: Client ID and Client Secret

These have already been made for you and you should not need to worry about these. However, if you do need to update the keys, make sure to **NEVER** update them directly in github. Instead, edit your [config variables](https://devcenter.heroku.com/articles/config-vars) in heroku.

If you want to change the development keys, open the development.rb file located in `config/environments` folder. You can replace the text after the equals sign within the single quotes (' ') for both the `GOOGLE_OAUTH_CLIENT_ID` and the `GOOGLE_OAUTH_CLIENT_SECRET` variables.

These should be different than values in your config variables in heroku.

See more info [here](https://developers.google.com/identity/protocols/oauth2)


## Deployment ##

Setup a Heroku account: https://signup.heroku.com/

From the heroku dashboard select `New` -> `Create New Pipline`

Name the pipeline, and link the respective git repo to the pipline

Our application does not need any extra options, so select `Enable Review Apps` right away

Click `New app` under review apps, and link your test branch from your repo

Under staging app, select `Create new app` and link your main branch from your repo

--------

To add enviornment variables to enable google oauth2 functionality, head over to the settings tab on the pipeline dashboard

Scroll down until `Reveal config vars`

Add both your client id and your secret id, with fields `GOOGLE_OAUTH_CLIENT_ID` and `GOOGLE_OAUTH_CLIENT_SECRET` respectively

Now once your pipeline has built the apps, select `Open app` to open the app

With the staging app, if you would like to move the app to production, click the two up and down arrows and select `Move to production`

And now your application is setup and in production mode!


## CI/CD ##

For continuous development, we set up Heroku to automatically deploy our apps when their respective github branches are updated.

  `Review app: test-s3 branch`

  `Production app: main branch`

For continuous integration, we set up a Github action to run our specs, security checks, linter, etc. after every push or pull-request. This allows us to automatically ensure that our code is working as intended.

## References ##

- https://www.w3schools.com/howto/howto_js_filter_table.asp

## Support ##

Admins looking for support should first look at the application help page.
Users looking for help seek out assistance from the customer.

If you have any further questions, feel free to reach out to any of the developers:
- Chris: christopher.pasala@gmail.com
- Axel: contact@axelramone.com
- Vrinda: jainvrinda14@gmail.com
