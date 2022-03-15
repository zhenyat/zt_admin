#! /bin/zsh
cd /Users/zhenya/ZT_Lab/Ruby/Gems/zt_admin
ZT_ADMIN_VERSION=`grep VERSION lib/zt_admin/version.rb |awk '{print $3}' |sed 's/"//g'`
echo "current version: ${ZT_ADMIN_VERSION}"
git add .; gem build zt_admin.gemspec; gem install --local zt_admin-$ZT_ADMIN_VERSION.gem; rm *.gem