#!/usr/bin/env bash
#
#
# 1. https://www.reddit.com/r/selfhosted/comments/vvimwa/comment/ifl77do/?utm_source=share&utm_medium=mweb3x&utm_name=mweb3xcss&utm_term=1&utm_content=share_button
#

# TODO(JEFF): This should be a critical
# exit when the user has not specified a
# hostname; we will not be able to rely
# upon automatic detection of any sort!
host="$1"
if [ -z "$host" ]; then
  host="pixel4a5g"
  # exit 2
fi

# Organization from step #1
Organization="syn"
#User="jeff-${host}"
User="jeff-${host}"
UserKey="${User}@${Organization}"
OrgPrefixPath="$HOME/.ssh/CA/${Organization}"

echo "O: ${Organization}"
echo "O_prefix: ${OrgPrefixPath}_CA.key"
echo
echo "USER: ${UserKey}"
echo

# try not to swipe existing key sets; this is our
# last opportunity to bail before new keys are 
# generated!
if [[ -r "$HOME/.ssh/CA" ]] || [[ -r "$OrgPrefixPath" ]]; then
  echo "CRITICAL: Halting the script due to pre-existing key setup..."
  echo
  exit 254
fi

# create keys for an user
# output path is subject to change
ssh-keygen -t rsa -b 4096 \
  -C "User description" \
-f "${UserKey}.key"

cp -av "${UserKey}.key" "${OrgPrefixPath}/${UserKey}.key" || exit 255
rm -f "${UserKey}.key"

# # Sign user's public key with your CA (certificate authority) key:
ssh-keygen -s "${OrgPrefixPath}_CA.key" \
  -I "user_${User}" \
  -n ${User} \
  -V "-1w:forever" \
  -z $RANDOM \
"${UserKey}.key.pub"
