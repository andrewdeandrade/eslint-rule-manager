#!/bin/sh
set -eu

cd `dirname $0`/..
ROOT_DIR=`pwd`

mkdir -p rules
cd rules
DEST_RULES_DIR=`pwd`

ESLINT_DIR=`mktemp -d -t eslint.XXXXXXXX`
trap "rm -rf $ESLINT_DIR >/dev/null 2>&1" EXIT

git clone git@github.com:nzakas/eslint.git $ESLINT_DIR

cd $ESLINT_DIR

ls

SRC_RULES_DIR=`pwd`/lib/rules
SRC_RULES_TESTS_DIR=`pwd`/tests/lib/rules

cd $SRC_RULES_DIR

for f in *.js; do
    RULE_NAME=${f%.js}
    mkdir -p ${DEST_RULES_DIR}/eslint/${RULE_NAME}/master
    mkdir -p ${DEST_RULES_DIR}/eslint/${RULE_NAME}/0.0.0

    if [ $RULE_NAME == "dot-notation" ] ; then
        mv ${SRC_RULES_TESTS_DIR}/dotnotation.js ${SRC_RULES_TESTS_DIR}/dot-notation.js
    fi

    if [ $RULE_NAME == "smarter-eqeqeq" ] ; then
        mv ${SRC_RULES_TESTS_DIR}/smartereqeqeq.js ${SRC_RULES_TESTS_DIR}/smarter-eqeqeq.js
    fi
    
    # master
    cp ${RULE_NAME}.js ${DEST_RULES_DIR}/eslint/${RULE_NAME}/master/index.js
    cp ${SRC_RULES_TESTS_DIR}/${RULE_NAME}.js ${DEST_RULES_DIR}/eslint/${RULE_NAME}/master/test.js

    # version 0.0.0
    cp ${RULE_NAME}.js ${DEST_RULES_DIR}/eslint/${RULE_NAME}/0.0.0/index.js
    cp ${SRC_RULES_TESTS_DIR}/${RULE_NAME}.js ${DEST_RULES_DIR}/eslint/${RULE_NAME}/0.0.0/test.js
done

exit 0