# Performance considerations
## Data bottlenecks
Both the Twitter API and Wikipedia API only allow you to return a limited number of results per call.
In Twitter's case the rate is also limited within a 15 minute window.  So you could implement some sort
of caching whose key would be the query term and the values can be a list of results.  A popular cache
strategy is the Least Recently Used algorithm.  If you use Redis, you can tune some additional
[parameters](http://redis.io/topics/lru-cache) to modify behavior that suits your user's needs.

Also the nature of the usage of Twitter and Wikipedia tend to be different.  Wikipedia pages themselves tend
to be sticky while the content on the pages tends to change over time.  Tweet consumption tends to be more
based on what is trendy and popular in the moment.  So something like Wikipedia pages could be better
served by storing in a more permanent data store like a database since pages and their titles which the URLs
are based off don't tend to change once established.  You could have a background job that moves Wikipedia
results into a table to generally insert and occasionally update out of date entries in the DB.

As an alternative for Wikipedia, you can actually download the entire wikipedia database.  Since the searching
is just on text this approach would just work fine.  You would then just need to update out of date entries
on a periodic basis.  Users would just be served from cache and local DB.

For tweets, it might make sense to set the cache invalidation to a much shorter time because most people
are usually looking for the most recent tweets anyway.  So basically you would have a cache for Twitter results
and a cache for Wikipedia results with the eviction timeouts being much longer for the Wikipedia cache.

## Usability bottlenecks
The current implementation calls the APIs from Rails server controller and blocks until the response comes back
or an error is thrown.  Either case means that the user can be waiting a long time.  To improve responsiveness,
using a separate Ajax call for each API call would help.  The skeleton of the search results page could be rendered
very quickly assuming the Rails server is up.  Then users could start looking at results from Twitter or Wikipedia
depending on which one returns first.  Also the current design would also potentially block a long time on either
service being slow to respond even though the other service has already responded since the API calls are made
serially.  The Ajax approach would avoid that issue.
