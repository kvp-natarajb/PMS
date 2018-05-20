# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@project_manager_one = User.create(full_name: "Naveen Kumar", email: "project_manager_1@gmail.com", password: "Admin@123", role: "admin")
@project_manager_two = User.create(full_name: "Keerthana", email: "project_manager_2@gmail.com", password: "Admin@123", role: "admin")
@developer_1 = User.create(full_name: "Ollie", email: "developer_1@gmail.com", password: "User@123", role: "developer")
@developer_2 = User.create(full_name: "Ollie", email: "developer_2@gmail.com", password: "User@123", role: "developer")
@developer_3 = User.create(full_name: "Ollie", email: "developer_3@gmail.com", password: "User@123", role: "developer")

@project = Project.create(owner_id: @project_manager_one.try(:id), name: "Defend the Wall", description: "defend the wall from the wildings", start_date: Date.today ,due_date: Date.today + 7.day, status: 0)
@project.collaborators << [@developer_1, @developer_2, @developer_3]
@project.save

@task_1 = Task.create(project_id: @project.try(:id), owner_id: @project_manager_one.try(:id), name: "Secure the tunnel", description: "flood the tunnel so it can't be be breached by the wildings", start_date: Date.today ,due_date: Date.today + 7.day, status: "new_task" )

@task_1.assigned_users <<  [@developer_1, @developer_2]

@task_2 = Task.create(project_id: @project.try(:id), owner_id: @project_manager_one.try(:id), name: "flood the tunnel so it can't be be breached", description: "flood the tunnel so it can't be be breached by the wildings", start_date: Date.today ,due_date: Date.today + 7.day, status: "in_progress" )

@task_2.assigned_users <<  [@developer_2, @developer_3]
