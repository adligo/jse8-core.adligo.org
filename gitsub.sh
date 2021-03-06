#!/bin/bash
#include <unistd.h>
#
# This checksout the sub projects, which are ignored
# These are in alphabetical order


#
#  This clones all of Adligo Inc's adligo.org projects underneath
# the folder where this script is run.
#
# --------------------- Apache License LICENSE-2.0 -------------------
#
#  Copyright 2022 Adligo Inc

#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

# Thanks https://medium.com/@Drew_Stokes/bash-argument-parsing-54f3b81a6a8f
while (( "$#" )); do
  case "$1" in
    -a | --async)   async="y" ; shift 1  ;;
    -h | --help) help="y" ; shift 1 ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done

function clone() {
  echo "in clone function with $1 $2"
  if [[ -d $1 ]]; then
    echo "$1 already exists :)"
  else 
    if [[ "$async" == "y" ]]; then
      if [[ -z $2 || "" == "$2" ]]; then
        clone_fun $1  &
      else
        clone_fun $1 $2 &
      fi
    else 
      if [[ -z $2 || "" == "$2" ]]; then
        clone_fun $1 
      else
        clone_fun $1 $2
      fi
    fi
  fi
}

function clone_fun() {
  echo "cloning $1 $2 async"
  if [[ -z $2 || "" == "$2" ]]; then
    git clone git@github.com:adligo/$1.git
  else
    git clone git@github.com:adligo/$1.git $2
  fi
  #echo "finished clone of $1"
  cd $1
  git checkout jse8
}
clone artifactory_deploy.sh.adligo.org

clone buildSrc.jse.core.kt.adligo.org buildSrc
clone bytes.adligo.org
clone bytes_gwt_examples.adligo.org
clone bytes_tests.adligo.org

clone collections.adligo.org
clone collections_gwt_examples.adligo.org
clone collections_tests.adligo.org
clone ctx.adligo.org
clone ctx_gwt_examples.adligo.org
clone ctx_tests.adligo.org

clone eclipse.adligo.org

clone gradle_kt_examples.adligo.org

clone i_bytes.adligo.org
clone i_collections.adligo.org
clone i_ctx.adligo.org
clone i_ctx4jse.adligo.org
clone i_pipe.adligo.org
clone i_tests4j.adligo.org
clone i_threads.adligo.org
clone i_threads4jse.adligo.org

clone mockito_ext.adligo.org

clone pipe.adligo.org
clone pipe_tests.adligo.org

clone ten.adligo.org
clone ten_gwt_examples.adligo.org
clone ten_tests.adligo.org

clone tests4j.adligo.org
clone tests4j_4mockito.adligo.org
clone tests4j4jj.adligo.org
clone tests4j4jj_tests.adligo.org
clone threads.adligo.org

wait
