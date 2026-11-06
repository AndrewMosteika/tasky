| Role         | Project                      | Task                         | Members                          |
| ------------ | ---------------------------- | ---------------------------- | -------------------------------- |
| Viewer       | read                         | read                         | read                             |
| Member       | read                         | read, create, update         | read                             |
| Admin        | read, update                 | read, create, update, delete | read; manage Viewers and Members |
| Owner        | read, update, delete         | read, create, update, delete | read; manage everyone            |
| Not a member | nothing                      | nothing                      | nothing                          |

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
