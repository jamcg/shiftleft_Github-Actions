#!/bin/bash

#this script needs the following variables to be defined
#TL_USER=username for the PC console
#TL_PASS=corresponding password
#TL_CONSOLE=PC console address

#create evilpetclinic collection
curl -k -u $TL_USER:$TL_PASS -H 'Content-Type: application/json' -X POST \
  -d '{"name":"evilpetclinic","containers":["*"],"hosts":["*"],"images":["*evilpetclinic*"],"labels":["*"],"appIDs":["*"],"functions":["*"],"namespaces":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"color":"#68DCFC"}' \
  https://$TL_CONSOLE/api/v1/collections

#create repo collection for app
curl -k -u $TL_USER:$TL_PASS "https://$TL_CONSOLE/api/v1/collections?project=Central+Console" \
  --data-raw '{"name":"app folder","containers":["*"],"hosts":["*"],"images":["*"],"labels":["*"],"appIDs":["*"],"functions":["*"],"namespaces":["*"],"accountIDs":["*"],"codeRepos":["/home/runner/work/shiftleft_Github-Actions/shiftleft_Github-Actions/app"],"clusters":["*"],"system":false,"color":"#2DFFAA"}' 


#looks like you need 2 different API calls to create this specific policy
#maybe due to the collection
curl -k -u $TL_USER:$TL_PASS "https://console-master-pasq2.prussiello.demo.twistlock.com/api/v1/policies/vulnerability/ci/coderepos?project=Central+Console" \
  -X 'PUT' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -d '{"rules":[{"effect":"alert, block","action":["*"],"condition":{"vulnerabilities":[]},"blockMsg":"","principal":[],"group":["*"],"verbose":false,"allCompliance":false,"onlyFixed":false,"cveRules":[],"tags":[],"collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2021-05-24T10:07:18.958Z","color":"#3FA2F7","description":"System - all resources collection","system":true,"prisma":false}],"name":"fail on high","alertThreshold":{"value":1,"disabled":false},"blockThreshold":{"value":7,"enabled":true},"owner":"prussiello_paloaltonetworks_com","modified":"2021-05-24T12:46:49.864Z"},{"modified":"2021-05-24T10:07:17.991Z","owner":"system","name":"Default - alert all components","previousName":"","effect":"alert","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2021-05-24T10:07:18.958Z","color":"#3FA2F7","description":"System - all resources collection","system":true,"prisma":false}],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"alertThreshold":{"disabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0},"graceDays":0,"license":{"alertThreshold":{"enabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0}}}],"policyType":"ciCodeRepoVulnerability","_id":"ciCodeRepoVulnerability","type":"vulnerability","policyContext":"ciCoderepos"}'

curl -k -u $TL_USER:$TL_PASS "https://console-master-pasq2.prussiello.demo.twistlock.com/api/v1/policies/vulnerability/ci/coderepos?project=Central+Console" \
  -X 'PUT' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -d '{"rules":[{"modified":"2021-05-24T12:54:11.351Z","owner":"prussiello_paloaltonetworks_com","name":"fail on high","previousName":"fail on high","effect":"alert, block","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["/home/runner/work/shiftleft_Github-Actions/shiftleft_Github-Actions/app"],"clusters":["*"],"name":"app folder","owner":"prussiello_paloaltonetworks_com","modified":"2021-05-24T12:27:19.102Z","color":"#2DFFAA","system":false,"prisma":false}],"action":["*"],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"group":["*"],"alertThreshold":{"disabled":false,"value":1},"blockThreshold":{"enabled":true,"value":7},"graceDays":0,"license":{"alertThreshold":{"enabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0}},"verbose":false,"allCompliance":false,"onlyFixed":false,"cveRules":[],"tags":[]},{"modified":"2021-05-24T10:07:17.991Z","owner":"system","name":"Default - alert all components","previousName":"","effect":"alert","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2021-05-24T10:07:18.958Z","color":"#3FA2F7","description":"System - all resources collection","system":true,"prisma":false}],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"alertThreshold":{"disabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0},"graceDays":0,"license":{"alertThreshold":{"enabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0}}}],"policyType":"ciCodeRepoVulnerability","_id":"ciCodeRepoVulnerability","type":"vulnerability","policyContext":"ciCoderepos"}' 

#code repo license compliance
curl -k -u $TL_USER:$TL_PASS "https://$TL_CONSOLE/api/v1/policies/compliance/ci/coderepos?project=Central+Console" \
  -X 'PUT' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"rules":[{"modified":"2021-05-24T08:07:51.787Z","owner":"prussiello_paloaltonetworks_com","name":"fail on WTFPL","previousName":"fail on WTFPL","disabled":false,"effect":"alert, block","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2021-05-09T14:10:28.076Z","color":"#3FA2F7","description":"System - all resources collection","system":true,"prisma":false}],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"alertThreshold":{"disabled":false,"value":1},"blockThreshold":{"enabled":false,"value":0},"graceDays":0,"license":{"alertThreshold":{"enabled":true,"value":1},"blockThreshold":{"enabled":true,"value":9},"critical":["WTFPL"],"high":["GPL-1.0","GPL-2.0","GPL-3.0","LGPL-2.1","LGPL-3.0","AGPL-3.0","AGPL-3.0-or-later","GPL-2.0-with-classpath-exception","EUPL-1.0","EUPL-1.1","EUPL-1.2"],"medium":["Artistic-1.0-Perl","EPL-1.0","MS-PL","MPL-1.0","MPL-1.1","MPL-2.0","CDDL-1.0","CDDL-1.1","CPAL-1.0","CPL-1.0","IPL-1.0","NPL-1.0","NPL-1.1"],"low":["MIT","Apache-1.0","Apache-1.1","Apache-2.0","BSD-3-Clause","ISC","BSD-2-Clause","CPOL-1.02","WTFPL","Zlib","ANTLR-PD","ICU","Info-ZIP"]},"verbose":false,"allCompliance":false,"onlyFixed":false,"cveRules":[],"tags":[]},{"modified":"2021-05-20T08:26:04.999Z","owner":"prussiello_paloaltonetworks_com","name":"Default - alert all components","previousName":"","effect":"alert","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2021-05-09T14:10:28.076Z","color":"#3FA2F7","description":"System - all resources collection","system":true,"prisma":false}],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"alertThreshold":{"disabled":false,"value":1},"blockThreshold":{"enabled":false,"value":0},"graceDays":0,"license":{"alertThreshold":{"enabled":true,"value":1},"blockThreshold":{"enabled":false,"value":0},"critical":["MIT"],"high":["GPL-1.0","GPL-2.0","GPL-3.0","LGPL-2.1","LGPL-3.0","AGPL-3.0","AGPL-3.0-or-later","GPL-2.0-with-classpath-exception","EUPL-1.0","EUPL-1.1","EUPL-1.2"],"medium":["Artistic-1.0-Perl","EPL-1.0","MS-PL","MPL-1.0","MPL-1.1","MPL-2.0","CDDL-1.0","CDDL-1.1","CPAL-1.0","CPL-1.0","IPL-1.0","NPL-1.0","NPL-1.1"],"low":["MIT","Apache-1.0","Apache-1.1","Apache-2.0","BSD-3-Clause","ISC","BSD-2-Clause","CPOL-1.02","WTFPL","Zlib","ANTLR-PD","ICU","Info-ZIP"]}}],"policyType":"ciCodeRepoCompliance","_id":"ciCodeRepoCompliance","type":"compliance","policyContext":"ciCoderepos"}' 

#CI Container vulnerability policy
curl -k -u $TL_USER:$TL_PASS "https://$TL_CONSOLE/api/v1/policies/vulnerability/ci/images?project=Central+Console" \
  -X 'PUT' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  -d '{"rules":[{"modified":"2021-05-24T13:47:46.936Z","owner":"prussiello_paloaltonetworks_com","name":"fail on critical","previousName":"","disabled":false,"effect":"alert, block","collections":[{"hosts":["*"],"images":["*evilpetclinic*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"evilpetclinic","owner":"prussiello_paloaltonetworks_com","modified":"2021-05-24T11:45:59.945Z","color":"#68DCFC","system":false,"prisma":false}],"action":["*"],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"group":["*"],"alertThreshold":{"disabled":false,"value":1},"blockThreshold":{"enabled":true,"value":7},"graceDays":0,"license":{"alertThreshold":{"enabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0}}},{"modified":"2021-05-24T11:46:00.028Z","owner":"prussiello_paloaltonetworks_com","name":"Default - alert all components","previousName":"","effect":"alert","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2021-05-24T10:07:18.958Z","color":"#3FA2F7","description":"System - all resources collection","system":true,"prisma":false}],"condition":{"readonly":false,"device":"","vulnerabilities":[]},"alertThreshold":{"disabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0},"graceDays":0,"license":{"alertThreshold":{"enabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0}}}],"policyType":"ciImagesVulnerability","_id":"ciImagesVulnerability","type":"vulnerability","policyContext":"ciImages"}' 
  
#CI Container compliance
curl -k -u $TL_USER:$TL_PASS "https://$TL_CONSOLE/api/v1/policies/compliance/ci/images?project=Central+Console" \
  -X 'PUT' \
  -H 'Content-Type: application/json;charset=UTF-8' \
  --data-raw '{"rules":[{"modified":"2021-05-23T08:33:37.547Z","owner":"prussiello_paloaltonetworks_com","name":"Fail on malware","previousName":"Fail on malware","disabled":false,"effect":"alert, block","collections":[{"hosts":["*"],"images":["*evilpetclinic*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"evilpetclinic","owner":"prussiello_paloaltonetworks_com","modified":"2021-05-10T08:07:36.402Z","color":"#68DCFC","system":false,"prisma":false}],"action":["*"],"condition":{"readonly":false,"device":"","vulnerabilities":[{"id":41,"block":false},{"id":422,"block":true},{"id":424,"block":false},{"id":425,"block":false},{"id":426,"block":false},{"id":448,"block":false},{"id":5041,"block":false}]},"group":["*"],"alertThreshold":{"disabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0},"graceDays":0,"license":{"alertThreshold":{"enabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0}},"verbose":false,"allCompliance":false,"onlyFixed":false,"cveRules":[],"tags":[]},{"modified":"2021-05-09T14:10:26.957Z","owner":"system","name":"Default - alert on critical and high","previousName":"","effect":"alert","collections":[{"hosts":["*"],"images":["*"],"labels":["*"],"containers":["*"],"functions":["*"],"namespaces":["*"],"appIDs":["*"],"accountIDs":["*"],"codeRepos":["*"],"clusters":["*"],"name":"All","owner":"system","modified":"2021-05-09T14:10:28.076Z","color":"#3FA2F7","description":"System - all resources collection","system":true,"prisma":false}],"condition":{"readonly":false,"device":"","vulnerabilities":[{"id":424,"block":false},{"id":425,"block":false},{"id":448,"block":false},{"id":422,"block":false},{"id":426,"block":false},{"id":5041,"block":false},{"id":41,"block":false}]},"alertThreshold":{"disabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0},"graceDays":0,"license":{"alertThreshold":{"enabled":false,"value":0},"blockThreshold":{"enabled":false,"value":0}}}],"policyType":"ciImagesCompliance","_id":"ciImagesCompliance","type":"compliance","policyContext":"ciImages"}' 
