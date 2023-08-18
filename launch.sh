#!/bin/bash
echo "INFO > Automation Petpartners"
cd /tmp/petpartners-automation
rm -r  /tmp/report/*
mkdir /tmp/report/
ls
pwd
echo "INFO > Starting Automation Test: $PROJECT"
set +e
gradle -version
java -version
echo "*******************************"
# this line is adding the condition to exclude a tag
ORIGINAL_S=$SUITE
SUITE="$SUITE$EXCLUDE"

echo "INFO> complete suite to execute: [$SUITE]"
case $PROJECT in
  all-projects)
        echo "*********** INFO > Execute All projects - Starting ***********"
        cd /tmp/petpartners-automation/petpartners-ui-orca/src/test/resources
        sed -i "/browser=/c browser=$BROWSER" $ENVIRONMENT
        sed -i "/generateGifImage=/c generateGifImage=$GENERATE_GIF_IMAGE" $ENVIRONMENT
        sed -i "/isEnabledOrcaMFA=/c isEnabledOrcaMFA=$MFA" $ENVIRONMENT
        cd /tmp/petpartners-automation/petpartners-ui-orca
        echo "INFO > gradle clean build cucumber -Psuite=\"${SUITE}\" -PpropertyFile=${ENVIRONMENT}"
        gradle clean build cucumber -Psuite="${SUITE}" -PpropertyFile=${ENVIRONMENT}
        cp /tmp/petpartners-automation/petpartners-ui-orca/build/reports/cucumber/report.json /tmp/report/report-orca.json
        cp /tmp/petpartners-automation/petpartners-ui-orca/build/reports/cucumber/report.html /tmp/report/report-orca.html

        cd /tmp/petpartners-automation/petpartners-ui-akc/src/test/resources
        sed -i "/browser=/c browser=$BROWSER" $ENVIRONMENT
        sed -i "/generateGifImage=/c generateGifImage=$GENERATE_GIF_IMAGE" $ENVIRONMENT
        sed -i "/isEnabledOrcaMFA=/c isEnabledOrcaMFA=$MFA" $ENVIRONMENT

        cd /tmp/petpartners-automation/petpartners-ui-akc
        echo "INFO > gradle clean build cucumber -Psuite=\"${SUITE}\" -PpropertyFile=${ENVIRONMENT}"
        gradle clean build cucumber -Psuite="${SUITE}" -PpropertyFile=${ENVIRONMENT}
        cp /tmp/petpartners-automation/petpartners-ui-akc/build/reports/cucumber/report.json /tmp/report/report-akc.json
        cp /tmp/petpartners-automation/petpartners-ui-akc/build/reports/cucumber/report.html /tmp/report/report-akc.html

        cd /tmp/petpartners-automation/petpartners-ui-ppi/src/test/resources
        sed -i "/browser=/c browser=$BROWSER" $ENVIRONMENT
        sed -i "/generateGifImage=/c generateGifImage=$GENERATE_GIF_IMAGE" $ENVIRONMENT
        sed -i "/isEnabledOrcaMFA=/c isEnabledOrcaMFA=$MFA" $ENVIRONMENT
        cd /tmp/petpartners-automation/petpartners-ui-ppi
        echo "INFO > gradle clean build cucumber -Psuite=\"${SUITE}\" -PpropertyFile=${ENVIRONMENT}"
        gradle clean build cucumber -Psuite="${SUITE}" -PpropertyFile=${ENVIRONMENT}
        cp /tmp/petpartners-automation/petpartners-ui-ppi/build/reports/cucumber/report.json /tmp/report/report-ppi.json
        cp /tmp/petpartners-automation/petpartners-ui-ppi/build/reports/cucumber/report.html /tmp/report/report-ppi.html

        cd /tmp/petpartners-automation/petpartners-api/src/test/resources
        sed -i "/browser=/c browser=$BROWSER" $ENVIRONMENT
        sed -i "/generateGifImage=/c generateGifImage=$GENERATE_GIF_IMAGE" $ENVIRONMENT
        sed -i "/isEnabledOrcaMFA=/c isEnabledOrcaMFA=$MFA" $ENVIRONMENT
        cd /tmp/petpartners-automation/petpartners-api
        echo "INFO > gradle clean build cucumber -Psuite=\"${SUITE}\" -PpropertyFile=${ENVIRONMENT}"
        gradle clean build cucumber -Psuite="${SUITE}" -PpropertyFile=${ENVIRONMENT}
        cp /tmp/petpartners-automation/petpartners-api/build/reports/cucumber/report.json /tmp/report/report-api.json
        cp /tmp/petpartners-automation/petpartners-api/build/reports/cucumber/report.html /tmp/report/report-api.html

        cd /tmp/petpartners-automation/petpartners-ui-paw-some/src/test/resources
        sed -i "/browser=/c browser=$BROWSER" $ENVIRONMENT
        sed -i "/generateGifImage=/c generateGifImage=$GENERATE_GIF_IMAGE" $ENVIRONMENT
        sed -i "/isEnabledOrcaMFA=/c isEnabledOrcaMFA=$MFA" $ENVIRONMENT
        cd /tmp/petpartners-automation/petpartners-ui-paw-some
        echo "INFO > gradle clean build cucumber -Psuite=\"${SUITE}\" -PpropertyFile=${ENVIRONMENT}"
        gradle clean build cucumber -Psuite="${SUITE}" -PpropertyFile=${ENVIRONMENT}
        cp /tmp/petpartners-automation/petpartners-ui-paw-some/build/reports/cucumber/report.json /tmp/report/report-pawsome.json
        cp /tmp/petpartners-automation/petpartners-ui-paw-some/build/reports/cucumber/report.html /tmp/report/report-pawsome.html
        echo "*********** INFO > Execute All projects - Completed ***********"
     ;;

  *)
   echo "**** INFO > Execute Project: $PROJECT - starting *****"
       cd /tmp/petpartners-automation/$PROJECT/src/test/resources
       sed -i "/browser=/c browser=$BROWSER" $ENVIRONMENT
       sed -i "/generateGifImage=/c generateGifImage=$GENERATE_GIF_IMAGE" $ENVIRONMENT
       sed -i "/isEnabledOrcaMFA=/c isEnabledOrcaMFA=$MFA" $ENVIRONMENT
       cat $ENVIRONMENT
       cd /tmp/petpartners-automation/$PROJECT
       echo "INFO > gradle clean build cucumber -Psuite=\"${SUITE}\" -PpropertyFile=${ENVIRONMENT}"
       gradle clean build cucumber -Psuite="${SUITE}" -PpropertyFile=${ENVIRONMENT}
       cp /tmp/petpartners-automation/$PROJECT/build/reports/cucumber/report.json /tmp/report/report-$PROJECT$ORIGINAL_S.json
       cp /tmp/petpartners-automation/$PROJECT/build/reports/cucumber/report.html /tmp/report/report-$PROJECT$ORIGINAL_S.html
       echo "**** INFO > Execute Project: $PROJECT - completed *****"
    esac
set -e
sleep 10s
echo "Generating HTML Cucumber Reporting"

cd /tmp/petpartners-automation/petpartners-common
gradle generateGlobalReport -Pfolder="/tmp/report/"

echo "INFO > Execution Complete"