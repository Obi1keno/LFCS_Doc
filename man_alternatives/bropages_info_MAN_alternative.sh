####_BORPAGES_####
# The bropages are just like man pages, but it will display examples only. #
yum install -y gem # install gem which will make it easy to install bropages.
yum install -y ruby-devel # install ruby dev env.
yum install -y rubygems # Ruby standard for packaging ruby libraries.
yum install -y rubygems-devel # macros and dev tools for packaging ruby gems.
gem install bropages # install bropages through gem.
bro find # display bropage of "find" commande.
bro thanks x # upvote x command example, need to input email id.
bro ...no x # downvote x command.
bro add find # submit your own example of find.
