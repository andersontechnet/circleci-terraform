<p align="center"><img src="https://raw.githubusercontent.com/fedekau/terraform-with-circleci-example/staging/.images/gears.png" height="200px"></p>

# circle-terraform

The main purpose is to show one of the many possible ways
you could manage VEERUM infrastructure using an Infrastructure as Code (IAC) tool
like [Terraform](https://www.terraform.io/) and a continuous integration tool
like [CircleCI](https://circleci.com).

We have followed many of the good practices described in the book [Terraform: Up & Running](https://www.terraformupandrunning.com/) and in the [CircleCI 2.0 Documentation](https://circleci.com/docs/2.0/). I will also assume you have some knowledge about those tools and [Amazon Web Services](https://aws.amazon.com) 

## Suggested workflow

Assuming you have two environments, `production` and `staging` and `dev`, when a new feature is requested you branch from `staging`, commit the code and open a PR to the `staging` branch, when you do, CircleCI will run two jobs, one for linting and one that will plan the changes to your `staging` infrastructure so you can review them (see image below).

![Image of PR creation jobs](https://raw.githubusercontent.com/fedekau/terraform-with-circleci-example/staging/.images/pr.png)

Once you merge the PR, if everything goes as planned CircleCI will run your jobs and will automatically deploy your infrastructure!

![Image of jobs after staging merge](https://raw.githubusercontent.com/fedekau/terraform-with-circleci-example/staging/.images/staging-merge.png)

After you have tested your infrastructure in `staging` you just need to open a PR from `staging` into `master` to "promote" you infrastructure into `production`.

In this case we want someone to manually approve the release into master, so after you merge you need to tell CircleCI that it can proceed and it will deploy the infrastructure after the confirmation.

![Image of jobs after master merge](https://raw.githubusercontent.com/fedekau/terraform-with-circleci-example/staging/.images/master-merge.png)

Now that you know what we want to achieve we will dive into the code...get ready!

## How is this repo structured?

I will explain each folder in the root level and dive into some of them, in another section I will explain the files contained in each folder (or at least the most important ones).

### Folder `.circleci`

This folder is where the configuration file for CircleCI is included, it usually
contains one file `config.yml`. But you can have scripts to do whatever you need to help you run your tests or checks there. In this case we only have one file: [config.yml](https://github.com/fedekau/terraform-with-circleci-example/blob/master/.circleci/config.yml).

### Folder `.keys`

It contains a public/private key pair, and before you shout at me, I know you **should never** have private keys in version control but for simplicity I have included them here.

### Folder `environments`

This folder has one folder for each environment, in this case it has `production` and `staging`, but it could have as many as you need! For example if you want each developer to have its own environment they could copy one of those folders and have one new environment, as easy as it sounds!

Each folder has some files that basically wrap the contents of the modules folder.

### Folder `modules`

Here we define all our infrastructure leaving some open parameters for customizing each environment, for example in `production` you want to run some powerful machines, but for `staging` you might want low power machines to reduce costs.

This folder has two folders, `state` which is a module for creating the required resources for managing terraform state remotely, an S3 bucket and a DynamoDB table, which we use in each environment. This is one possibility of the [many available](https://www.terraform.io/docs/backends/). The second folder `infrastructure` contains the definition of all the infrastructure which we use in each environment.

### Folder `shared`

This folder is for throwing some shared files. In order to use the files we simply create a symbolic link wherever we need to use its contents.

## Modules

Terraform allows you to create and use modules. That enables us to reuse code.

## Terraform State S3  

Terraform State S3 encapsulate the resources for our backend of choice: S3 Bucket for the state file and DynamoDB for state locking.

 See [Terraform Backends](https://www.terraform.io/docs/backends/index.html) for all the alternatives.

## Infrastructure module

Here I have used the module idea to create a `infrastructure` module that represents everything that is needed to run our apps, that means that every time you use that module you get an exact copy of your infrastructure.

In this repo I use it to create different environments, but you could also use it for creating your custom version of [Heroku's Review Apps](https://devcenter.heroku.com/articles/github-integration-review-apps)

This module is only glue for the modules it includes, in the [modules/environment/main.tf](https://github.com/fedekau/terraform-with-circleci-example/blob/staging/modules/infrastructure/main.tf) file we glue the `network`, `instances` and `databases` modules.

## License

terraform-with-circleci-example is licensed under the MIT license.

See [LICENSE.md](https://github.com/fedekau/terraform-with-circleci-example/blob/staging/LICENSE.md) for the full license text.
