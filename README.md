# GALLERY

## Requirements

This project require:

* Ruby 2.3.1

## Local development settings

You can run this project on your local development machine by following next steps. 

* Disable carrierwave on Image model by comment "mount_uploader" and "validates_processing_of" strings

* Run `rake upload_files:upload_files_from_local_dir`

* Enable carrierwave on Image model by uncomment "mount_uploader" and "validates_processing_of" strings

* Run `rake upload_files:recreate_thumb_versions`

## Authors

* Anton Storchak

