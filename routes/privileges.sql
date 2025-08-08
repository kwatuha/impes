-- SQL Insert Script for KEMRI Roles and Privileges

-- -----------------------------------------------------
-- 1. Insert Roles into kemri_roles table
-- -----------------------------------------------------
INSERT INTO kemri_roles (role_name, description) VALUES
('admin', 'Full administrative access to the system.'),
('manager', 'Manages projects and oversees staff activities.'),
('data_entry', 'Can enter and modify raw data.'),
('viewer', 'Can view dashboards and reports, but cannot modify data.'),
('project_lead', 'Leads specific projects, can manage tasks and milestones within their projects.'),
('user', 'Standard user with basic access.');

-- -----------------------------------------------------
-- 2. Insert Privileges into kemri_privileges table
-- -----------------------------------------------------
INSERT INTO kemri_privileges (privilege_name, description) VALUES
-- User Management Privileges
('user.read_all', 'Allows viewing all user accounts.'),
('user.create', 'Allows creating new user accounts.'),
('user.update', 'Allows updating existing user accounts.'),
('user.delete', 'Allows deleting user accounts.'),

-- Project Management Privileges
('project.read_all', 'Allows viewing all projects.'),
('project.create', 'Allows creating new projects.'),
('project.update', 'Allows updating existing projects.'),
('project.delete', 'Allows deleting projects.'),
('project.manage_own', 'Allows managing projects assigned to the user (e.g., project lead).'),

-- Task Management Privileges (within projects)
('task.read_all', 'Allows viewing all tasks across projects.'),
('task.create', 'Allows creating new tasks.'),
('task.update', 'Allows updating existing tasks.'),
('task.delete', 'Allows deleting tasks.'),
('task.manage_assignees', 'Allows assigning/unassigning staff to tasks.'),
('task.manage_dependencies', 'Allows managing task dependencies.'),

-- Milestone Management Privileges (within projects)
('milestone.read_all', 'Allows viewing all milestones across projects.'),
('milestone.create', 'Allows creating new milestones.'),
('milestone.update', 'Allows updating existing milestones.'),
('milestone.delete', 'Allows deleting milestones.'),

-- Data Management Privileges
('raw_data.view', 'Allows viewing raw data.'),
('raw_data.export', 'Allows exporting raw data.'),
('raw_data.create', 'Allows adding new raw data entries.'),
('raw_data.update', 'Allows modifying raw data entries.'),
('raw_data.delete', 'Allows deleting raw data entries.'),

-- Dashboard & Reporting Privileges
('dashboard.view', 'Allows viewing the main dashboard.'),
('reports.view_all', 'Allows viewing all system reports.');


-- -----------------------------------------------------
-- 3. Assign Privileges to Roles in kemri_role_privileges table
--    (Adjust these assignments based on your specific access requirements)
-- -----------------------------------------------------

-- Get Role IDs (assuming auto-incremented IDs based on insertion order, or fetch dynamically)
-- It's safer to fetch IDs if you're not sure about the order, but for a fresh script, this works.
SET @admin_role_id = (SELECT role_id FROM kemri_roles WHERE role_name = 'admin');
SET @manager_role_id = (SELECT role_id FROM kemri_roles WHERE role_name = 'manager');
SET @data_entry_role_id = (SELECT role_id FROM kemri_roles WHERE role_name = 'data_entry');
SET @viewer_role_id = (SELECT role_id FROM kemri_roles WHERE role_name = 'viewer');
SET @project_lead_role_id = (SELECT role_id FROM kemri_roles WHERE role_name = 'project_lead');
SET @user_role_id = (SELECT role_id FROM kemri_roles WHERE role_name = 'user');

-- Get Privilege IDs
SET @user_read_all_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'user.read_all');
SET @user_create_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'user.create');
SET @user_update_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'user.update');
SET @user_delete_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'user.delete');

SET @project_read_all_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'project.read_all');
SET @project_create_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'project.create');
SET @project_update_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'project.update');
SET @project_delete_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'project.delete');
SET @project_manage_own_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'project.manage_own');

SET @task_read_all_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'task.read_all');
SET @task_create_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'task.create');
SET @task_update_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'task.update');
SET @task_delete_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'task.delete');
SET @task_manage_assignees_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'task.manage_assignees');
SET @task_manage_dependencies_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'task.manage_dependencies');

SET @milestone_read_all_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'milestone.read_all');
SET @milestone_create_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'milestone.create');
SET @milestone_update_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'milestone.update');
SET @milestone_delete_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'milestone.delete');

SET @raw_data_view_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'raw_data.view');
SET @raw_data_export_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'raw_data.export');
SET @raw_data_create_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'raw_data.create');
SET @raw_data_update_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'raw_data.update');
SET @raw_data_delete_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'raw_data.delete');

SET @dashboard_view_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'dashboard.view');
SET @reports_view_all_priv_id = (SELECT privilege_id FROM kemri_privileges WHERE privilege_name = 'reports.view_all');


-- Admin Role: All Privileges
INSERT INTO kemri_role_privileges (role_id, privilege_id) VALUES
(@admin_role_id, @user_read_all_priv_id),
(@admin_role_id, @user_create_priv_id),
(@admin_role_id, @user_update_priv_id),
(@admin_role_id, @user_delete_priv_id),
(@admin_role_id, @project_read_all_priv_id),
(@admin_role_id, @project_create_priv_id),
(@admin_role_id, @project_update_priv_id),
(@admin_role_id, @project_delete_priv_id),
(@admin_role_id, @task_read_all_priv_id),
(@admin_role_id, @task_create_priv_id),
(@admin_role_id, @task_update_priv_id),
(@admin_role_id, @task_delete_priv_id),
(@admin_role_id, @task_manage_assignees_priv_id),
(@admin_role_id, @task_manage_dependencies_priv_id),
(@admin_role_id, @milestone_read_all_priv_id),
(@admin_role_id, @milestone_create_priv_id),
(@admin_role_id, @milestone_update_priv_id),
(@admin_role_id, @milestone_delete_priv_id),
(@admin_role_id, @raw_data_view_priv_id),
(@admin_role_id, @raw_data_export_priv_id),
(@admin_role_id, @raw_data_create_priv_id),
(@admin_role_id, @raw_data_update_priv_id),
(@admin_role_id, @raw_data_delete_priv_id),
(@admin_role_id, @dashboard_view_priv_id),
(@admin_role_id, @reports_view_all_priv_id);


-- Manager Role: View users, full project management, view raw data, view dashboard/reports
INSERT INTO kemri_role_privileges (role_id, privilege_id) VALUES
(@manager_role_id, @user_read_all_priv_id),
(@manager_role_id, @project_read_all_priv_id),
(@manager_role_id, @project_create_priv_id),
(@manager_role_id, @project_update_priv_id),
(@manager_role_id, @project_delete_priv_id),
(@manager_role_id, @task_read_all_priv_id),
(@manager_role_id, @task_create_priv_id),
(@manager_role_id, @task_update_priv_id),
(@manager_role_id, @task_delete_priv_id),
(@manager_role_id, @task_manage_assignees_priv_id),
(@manager_role_id, @task_manage_dependencies_priv_id),
(@manager_role_id, @milestone_read_all_priv_id),
(@manager_role_id, @milestone_create_priv_id),
(@manager_role_id, @milestone_update_priv_id),
(@manager_role_id, @milestone_delete_priv_id),
(@manager_role_id, @raw_data_view_priv_id),
(@manager_role_id, @dashboard_view_priv_id),
(@manager_role_id, @reports_view_all_priv_id);

-- Data Entry Role: Create/Update raw data, view dashboard
INSERT INTO kemri_role_privileges (role_id, privilege_id) VALUES
(@data_entry_role_id, @raw_data_create_priv_id),
(@data_entry_role_id, @raw_data_update_priv_id),
(@data_entry_role_id, @dashboard_view_priv_id);

-- Viewer Role: View only dashboard, raw data, and reports
INSERT INTO kemri_role_privileges (role_id, privilege_id) VALUES
(@viewer_role_id, @dashboard_view_priv_id),
(@viewer_role_id, @raw_data_view_priv_id),
(@viewer_role_id, @reports_view_all_priv_id),
(@viewer_role_id, @project_read_all_priv_id),
(@viewer_role_id, @task_read_all_priv_id),
(@viewer_role_id, @milestone_read_all_priv_id);

-- Project Lead Role: Manage their own projects, view all projects, manage tasks/milestones within projects
INSERT INTO kemri_role_privileges (role_id, privilege_id) VALUES
(@project_lead_role_id, @project_read_all_priv_id),
(@project_lead_role_id, @project_manage_own_priv_id), -- Specific privilege for managing assigned projects
(@project_lead_role_id, @task_read_all_priv_id), -- Can view all tasks to understand context
(@project_lead_role_id, @task_create_priv_id),
(@project_lead_role_id, @task_update_priv_id),
(@project_lead_role_id, @task_delete_priv_id),
(@project_lead_role_id, @task_manage_assignees_priv_id),
(@project_lead_role_id, @task_manage_dependencies_priv_id),
(@project_lead_role_id, @milestone_read_all_priv_id), -- Can view all milestones
(@project_lead_role_id, @milestone_create_priv_id),
(@project_lead_role_id, @milestone_update_priv_id),
(@project_lead_role_id, @milestone_delete_priv_id),
(@project_lead_role_id, @dashboard_view_priv_id);

-- User Role: Basic dashboard view, perhaps view their own profile/data
INSERT INTO kemri_role_privileges (role_id, privilege_id) VALUES
(@user_role_id, @dashboard_view_priv_id);

-- You might also want to add a default admin user if you don't have one
-- Make sure to hash the password before inserting into kemri_users
-- Example:
-- INSERT INTO kemri_users (username, email, password_hash, first_name, last_name, role)
-- VALUES ('adminuser', 'admin@example.com', '$2a$10$YOUR_HASHED_PASSWORD_HERE', 'Admin', 'User', 'admin');
