# Kinney

An oral history video site and administrative interface packaged as a Rails gem. Uses HTML5 video.

[![Build Status](https://travis-ci.org/jronallo/kinney.png)](https://travis-ci.org/jronallo/kinney)

# Story

This code was originally part of the [Student Leadership Initiative](http://d.lib.ncsu.edu/student-leaders/). It has since been extracted and significantly updated and refactored. The codename for the internal project is Sleader, so this project was named Kinney. Sleader-Kinney.

# Requirements

- Rails 4
- ElasticSearch

# Install

- Create a fresh Rails application `rails new olympia` and `cd olympia`
- Add the following to your Gemfile:

```
gem 'kinney', git: 'https://github.com/jronallo/kinney.git', branch: 'master'
gem 'font-awesome-sass-rails'
gem 'activeadmin', git: 'https://github.com/gregbell/active_admin.git', branch: 'master'
```

- `bundle install`
- `bundle exec rake kinney:install:migrations db:migrate`
- `bundle exec rails generate kinney:install` and `bundle install`. You may have to `bundle update compass-rails` for bundle install to complete.
- Seed the database: `bundle exec rake db:seed`
- Add an ExecJS runtime for your environment. In your Gemfile you can uncomment `gem 'therubyracer'`
- Add a devise secret key to config/initializers/devise.rb. You can create a good new secret to use with `rake secret`.

```
config.secret_key = 'a better secret key than this'
```

- `bundle exec rails c` to enter the Rails console and then `Kinney::AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')` and `exit` to return to your shell.
- Start the Rails server (`bundle exec rails s`) and go to <http://localhost:3000/admin>. Login with the credentials above.
- Add a Topic.
- Add a Person.
- Now we need to put some video and related files where kinney can find them. By default video and related assets are served up from your app under /public/media/ directory and images from /public/photos/. (Later we'll see how to override these defaults to use a different asset host.) For now we can just add some dummy data from the kinney gem.

 Either check out the kinney code with `git clone https://github.com/jronallo/kinney.git` or find where your installed gem is with `bundle show kinney`. From the root of either copy over the directories public/media and public/photos into your own application's public directory.

- Add a Clip (currently video only). If you have the dummy data you can add "tolson-roots" as the Filename for a clip. Make this clip a "top pick".
- Visit the home page at <http://localhost:3000> and you should see the poster for your video. Click on it to go to the video play page. Ensure that the video plays.
- Read the following to learn how to configure your new oral history site.

# Configuration

When running the Kinney installation generator several files were created and some of those need to be configured. Many views can also be overridden in your application. Finally, all models and most controllers are implemented as Concerns so it is easy to override specific methods or actions in your application or add new features.

## Generated

### app/helpers/application_helper.rb
The installer asked you for your application name. Should you ever want to change it you can update the ApplicationHelper#application_name method.

### app/models/kinney/clip.rb
Defines Kinney::Clip#siskel_path which is used in several places to calculate the URL to your HTML5 Video, poster images, and webvtt files. You will definitely want to update this method to reflect where your HTML5 Video is stored. You can change it

Note that this uses the convention of storing all access derivatives for a single video within one directory. Here's an example directory structure.

<pre>
media
├── atkins-campuslife_fire
│   ├── atkins-campuslife_fire.mp4
│   ├── atkins-campuslife_fire.png
│   ├── atkins-campuslife_fire.vtt
│   └── atkins-campuslife_fire.webm
...
└── tolson-roots
    ├── tolson-roots.mp4
    ├── tolson-roots.png
    ├── tolson-roots-transcript.pdf
    ├── tolson-roots-transcript.txt
    ├── tolson-roots.vtt
    └── tolson-roots.webm
</pre>

If your videos do not follow this convention, then you may have to override other methods of a Kinney::Clip like png, mp4, webm, and vtt to provide a correct URL.

- Kinney::Clip#png is used for video poster image URLs.
- Kinney::Clip#mp4 and Kinney::Clip#webm are used for the video URLs. Currently to cover the most modern browsers you'll want to create both MP4 and WebM access copies of your video.
- Kinney::Clip#vtt is for WebVTT captioning if available.

Instead of adding these files to you application and placing them under version control, you may consider keeping this simple structure and the defaults in place and using symlinks for this directory.

### app/models/kinney/image.rb
This file is generated so that the image model can have an #external_url method. This allows you to link out from an image modal to the original image where you might have more information about the resource.

See below for helpers that can be used for changing image tags. For instace we use Djatoka to dynamically serve up squared, cropped images.

### config/routes.rb

Routes are generated for the admin interface, login, mounting the kinney engine, and setting the application root.

You may want to change where kinney is mounted to be at the root of your application:
```
mount Kinney::Engine => "/", :as => 'kinney'
```

Or at some other mount point:
```
mount Kinney::Engine => "/oral-histories", :as => 'kinney'
```
This can allow you to have a kinney oral history project inside another Rails application.

You may also want to change the root of your application to point to your own application's home page.

You may have to restart your server for this change to show up.

### config/initializers/active_admin.rb

You may want to `config.site_title`.

### Google Analytics in config/application.rb

Update the generated google analytics id to turn on page and event tracking.

### Authentication

In order for the mailer within the devise authentication system to work you will need to configure the mailer for each environment under config/environments/.

If you haven't already please add the secret_key to config/initializers/devise.rb.

In config/initializers/devise.rb add
`config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'`


## Views to Override

Every view template within the public portion of the site can be overridden. You'll want to override all of the following views. Most of these are noted within the interface so should be obvious where they effect the display. In some cases you may just want to include a blank template.

### app/views/layouts/kinney/\_brand\_above\_navbar.html.erb<br>app/views/layouts/kinney/\_brand\_below\_navbar.html.erb

These will need to be overridden to change the Sleater-Kinney orange that shows up above the main navbar. These partials allow for customing the brand of the site.

### app/views/kinney/pages/\_home_header.html.erb

If you need to have some kind of other large header on your home page, this is the file to update.

### app/views/layouts/kinney/_footer.html.erb

You probably want more in your footer than just about and contact links.

### app/views/kinney/pages/\_about\_text.html.erb<br>app/views/kinney/_contact.html.erb

Both the \_about_text and _contact partials show up on the about page and will need to be overridden in your own application.

### Many other views

Look through the kinney source code for other views you may want to override. In some cases small portions of the page have been broken out into partials to make this easier without a lot of copying.

## Helpers

Look under the kinney gem's app/helpers/kinney/ directory for helpers you may want to override.

### app/helpers/kinney/clip_index_partial_helper.rb

The index view for clips (<http://localhost:3002/kinney/videos>) has two different views available. You can select which partial you would like to use by overriding this helper.

1. clips_grouped_by_person is good for when each person has several short clips. This view avoids having the same head show up too many times.
2. all_clips shows each individual clip. This means that if a person is in more than one interview they will show up more than once on the page.

## JavaScript

If you change where media is served up from (if you move it out of public/media/) then you will also want to override app/assets/javascripts/kinney/admin/siskel_path.js which is used in the admin interface to load the video and check for the presence of a WebVTT file. Loading the video in this way allows for the duration field to be automatically updated based on the loaded video. Loading the video dynamically also ensures that the name of the video is entered correctly before saving.

## Translations

The gem uses the [Rails Internationalization API](http://guides.rubyonrails.org/i18n.html) to allow for translations. This also makes it easy to use config/locales/en.yml to override some of the headings and other test that shows on the page.

If you have a good translation that could be used as the default for a language other than English, please let me know.

# Rake tasks

`bundle exec rake kinney:reindex` will reindex in elasticsearch.

# Development

`bundle exec rake test`

# Running the Dummy App

You may need to drop the ElasticSearch index at time:

```
bundle exec rake environment app:tire:index:drop INDEX=kinney\_dummy_development
```

Then you need to go into the dummy directory to start the app:

```
cd test/dummy
bundle exec rails s
```

# Author

Jason Ronallo

# License

See MIT-LICENSE.