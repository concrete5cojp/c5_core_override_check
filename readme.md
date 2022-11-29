# Concrete CMS Core Override Checker

Concrete CMS Core override checker is the very simple interactive tool to check if your Concrete CMS core directory has some overrides from concrete5 original package.

You need to upload this shell script to the server and run it directory from server (Or download the file to run locally)

## Concept and Purpose.

Usually, you are NOT supposed to modify anything underneath of `/concrete` directory by design.

However, sometime you had to do it, or somebody else did.

This becomes critical at the time of the upgrade, especially for the project that you took over from someone else.

People forget things.

Therefore, I made this shell script to check to make sure if anybody else (including you) didn't override the concrete5 core, so that you can proceed the upgrade.

## How it works

- It copies the concrete directory from web server to working directory
- It downloads the concrete5 original package from concretecms.org server & extract the zip file.
- Run a DIFF command.
- Check if the diff file size is zero or not.
- If it's not zero, it gives you warning and save the diff file
- Deletes the working files.

## Requirement

- You need to have the basic understanding of the server.
- The server needs to be able to run shell script, and have necessary tools (this shell script uses very basic tools)

## How to set it up

- Open `c5_core_override.chech.sh` file. Make sure you have execution rights.
- Check the file permission of concrete5 folder.
- Change the CONCRETE5_VERSION & URL_CONCRETE5 to your preferred version and download link. You can get the download URL from [concrete5.org Download page](https://www.concrete5.org/developers/developer-downloads/)
- Upload the shell script to the server

## How to run

- Get the working directory full path. (I recommend to use under home directory.) Make some empty directory, then use `pwd` command to get the path.
- Get the concrete5 directory full path. Go to the concrete5 root directory and run `pwd` command.
- No slash at the end

```
$ cd [shell script location]
$ sh c5_core_override_check.sh [path to working directory] [path to concrete5 directory] [Concrete CMS version] [Concrete CMS download URL]
```

### Example command

```
$ cd
$ mkdir c5_check
$ # Check using default Concrete CMS version
$ sh c5_core_override_check.sh "/home/ec2-user/c5_check" "/var/www/vhosts/concrete5.co.jp/"
$ # Indicate Concrete CMS versiona and download URL
$ sh c5_core_override_check.sh "/home/ec2-user/c5_check" "/var/www/vhosts/concrete5.co.jp/ 9.1.3 https://www.concretecms.com/download_file/f7867cc1-3cbd-45b6-8df7-66ea2151eda0"
```

## What to check the result

If there is core override, it will generate concrete5_YYYYMMDDHHMMSS.diff file under working directory.

Download & open the diff file, and check the modifications.

# Version History

Date | Version | Comment
----|-----|------
2022/11/29 | 1.0.0 | - Added version and download URL option<br>Added support for 8.5.9 and later
2020/8/25 | 0.9.0 | Initial Version

# License

The MIT License (MIT)

# Credit

- Katz (Macareux Digital, Inc.)
    - [GitHub @katzueno](https://github.com/katzueno)
    - [Twitter in English @katz515](https://twitter.com/katz515)
    - [Twitter in Japanese @katzueno](https://twitter.com/katzueno)
    - [Instagram @katzueno](https://instagram/katzueno)
    - [Instagram Japanese Curry Rice @katzcurry](https://instagram/katzcurry)
    - [Web: katzueno.com](https://katzueno.com)
