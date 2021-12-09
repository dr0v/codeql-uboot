import cpp

from Macro mac
where mac.getName().regexpMatch("ntohs|ntohl|ntohll")
select mac,"is match ntoh*"

