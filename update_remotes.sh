#!/bin/bash
# Script to add the remote Github repos for dev versions.
#
TARGET=$1
# Use current dir as default
if [ -z "$TARGET" ]; then
  TARGET=`pwd -P`
fi
TARGET=`cd "$TARGET"; pwd -P`
echo "Updating git remotes for profile..."
echo ""
echo ""
echo "----------------------------------"
echo "Profile: Restaurant"
echo "----------------------------------"
if ! (git remote | grep drupal -q); then
  # Rename origin to drupal
  git remote rename origin drupal
  git remote set-url drupal arshad@git.drupal.org:project/restaurant.git
fi
if ! (git remote | grep github -q); then
  # Add Github remote
  git remote add --track 7.x-1.x github git@github.com:drupalrestaurant/restaurant.git
fi
# Pull latest code from Github
echo "Pulling latest version of profile restaurant from Github..."
git pull github 7.x-1.x

echo 'Updating git remotes for modules...'
submodules=( "admin" "base" "blog" "dashboard" "demo" "event" "foursquare" "location" "mail" "menu" "opentable" "pages" "plugins" "reservation" "seo" "slideshow" "theme" "user" "widgets" "yelp")
for subdir in "${submodules[@]}"
do
  if [ -e "$TARGET/modules/restaurant/restaurant_$subdir/.git" ]; then
    cd $TARGET/modules/restaurant/restaurant_$subdir
    echo ""
    echo ""
    echo "----------------------------------"
    echo "Module: restaurant_$subdir"
    echo "----------------------------------"
    if ! (git remote | grep drupal -q); then
      # Rename origin to drupal
      git remote rename origin drupal
      git remote set-url drupal arshad@git.drupal.org:project/restaurant_$subdir.git
    fi
    if ! (git remote | grep github -q); then
      # Add Github remote
      git remote add --track 7.x-1.x github git@github.com:drupalrestaurant/restaurant_$subdir.git
    fi
    # Pull latest code from Github
    echo "Pulling latest version of module restaurant_$subdir from Github..."
    git pull github 7.x-1.x
  else
    echo "No git repository found for module $subdir"
  fi
done

echo 'Updating git remotes for themes...'
subthemes=( "restaurant_radix" "restaurant_octal" )
for subdir in "${subthemes[@]}"
do
  if [ -e "$TARGET/themes/$subdir/.git" ]; then
    cd $TARGET/themes/$subdir
    echo ""
    echo ""
    echo "----------------------------------"
    echo "Theme: restaurant_$subdir"
    echo "----------------------------------"
    if ! (git remote | grep drupal -q); then
      # Rename origin to drupal
      git remote rename origin drupal
      git remote set-url drupal arshad@git.drupal.org:project/$subdir.git
    fi
    if ! (git remote | grep github -q); then
      # Add Github remote
      git remote add --track 7.x-1.x github git@github.com:drupalrestaurant/$subdir.git
    fi
    # Pull latest code from Github
    echo "Pulling latest version of theme restaurant_$subdir from Github..."
    git pull github 7.x-1.x
  else
    echo "No git repository found for theme $subdir"
  fi
done