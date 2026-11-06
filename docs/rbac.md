| Role         | Project                      | Task                         | Members                          |
| ------------ | ---------------------------- | ---------------------------- | -------------------------------- |
| Viewer       | read                         | read                         | read                             |
| Member       | read                         | read, create, update         | read                             |
| Admin        | read, update                 | read, create, update, delete | read; manage Viewers and Members |
| Owner        | read, update, delete         | read, create, update, delete | read; manage everyone            |
| Not a member | nothing                      | nothing                      | nothing                          |

Note: Creating a project isn't a role permission: any signed-in user can create one and becomes its Owner.

Rules:
1. Deny access by default. 
2. No self promotion i.e. an admin can only add and remove members and 
   viewers, while owners can create or change admin or owner.
3. Every project needs at least one owner (last owner cannot leave)
4. non-members get a 404, not a 403. "Not authorized" would confirm the project exists.
5. Assignees can only be members of the task's project
6. server dictates with the controller before anything changes
7. forgetting/ skipping a check is an error

Data Model:

| Model      | Columns                                                                 | Associations                                                         |
| ---------- | ----------------------------------------------------------------------- | -------------------------------------------------------------------- |
| User       | email_address, password_digest                                          | has many memberships; has many projects through memberships          |
| Membership | user_id, project_id, role (viewer 0, member 1, admin 2, owner 3)        | belongs to user and project; one per user per project (unique index) |
| Project    | name, description                                                       | has many memberships, users (through memberships) and tasks          |
| Task       | project_id, title, description, status, due_on, creator_id, assignee_id | belongs to project and creator (User); optionally to assignee (User) |

Threat List (Phase 7)

| Attack                                                                                      | Defence                                                                    |
| ------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| A viewer sends an edit request directly, skipping the hidden button                         | Pundit authorize in every controller action                                |
| A non-member types /project/5                                                               | Projects are only ever found through your memberships, so this returns 404 |
| A task is reached through the wrong project: /projects1/tasks/9 when task 9 is in project 2 | Tasks are only found through their project @project.tasks.find             |
| An Admin promotes themselves or a friend to Owner                                           | MembershipPolicy: Admins only touch Viewer and Member memberships          |
| Sign-up form sent with an extra role=owner field                                            | Users have no role column, and strong parameters drop unknown fields       |
| The last Owner leaves or is demoted, orphaning the project                                  | A validation and a before_destroy check on Membership                      |
| A task is assigned to someone outside the project                                           | Validation on Task                                                         |
| A new controller action forgets to check permissions                                        | verify_pundit_authorization raises an error, so the tests fail             |