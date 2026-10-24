# ~/.bash/bashrc.d/inference.sh:jeff
#
# shellcheck shell=bash
#
# Local compute inference env
#
# SEE ALSO
# 1. omp
# 2. lms
#

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/jeff/.lmstudio/bin"
# End of LM Studio CLI section

# http://scorpio.home.arpa:9932/v1/models
LM_STUDIO_BASE_URL="http://localhost:9932"

if [[ -n "$LM_STUDIO_BASE_URL" ]] && [[ "$LM_STUDIO_BASE_URL" != "" ]]; then
  export LM_STUDIO_BASE_URL
fi

#LM_STUDIO_API_KEY=""

#if [[ -n "$LM_STUDIO_API_KEY" ]] && [[ "$LM_STUDIO_API_KEY" != "" ]]; then
#  export LM_STUDIO_API_KEY
#fi

