hireology
=========

This solution was adapted from the blogpost found here: http://www.adomokos.com/2012/10/the-organizations-users-roles-kata.html

Summary:

The challenge consisted of writing logic to handle permissions and inheritence of those permissions through a multi tired organizational structure. My solution relies on some assumptions that I made about the permissions:

1. Admin role always has access to all of its child orgs, unless they are explicitely denied.
2. User roles do not have access to their child orgs, but their parent orgs do have access to them.
3. Parents cannot access child orgs with Denied roles. It is also assumed that only child orgs (not regular orgs or the root org) can have Denied roles.

I have 2 files, one containing the Organization class and the other containing the OrganizationTree class.

To see the tests run:

1. In the terminal, navigate to the root directory of the project.
2. Type 'bundle install' to install the necessary gems.
3. Type 'rspec spec' to see the tests run.
