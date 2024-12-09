
Overview of project:

Model and Database migrations: <br />
I put the database structure same as described. To support high throughput, I put index on duration, and created at, since these 2 fields mainly used as sorting fields.
If we want take a step further, on sleep records table, we can add additional fields for date field, we can implement partitioning, and use that date as field for partitioning.

Project structure<br />
For this project structure, I separate between logic and controller layer. Assuming this project will become a long term project where we need to add feature time by time, it's better to separate usage of logics. Heavy logics placed in Service directory, as well as filter and sorting file. This will make then reusable and way more easier to maintain in long term period. The downside is it's somewhat complicated to someone not used of this kind of structure. Serializer is the same as rails serializer in general.

JSON schema<br />
As instructed, I used restful API to implement this, so this is rails api only project. this is the postman collection for this project<br />
[JSON request collection](https://github.com/user-attachments/files/18062224/Screenshot.2024-12-09.at.16.43.59.json)

Test cases<br />
I use rspec gem to implement this, I make sure this project is 100% code coveraged. The test cases covers for all controllers, models, and services. I don't test each of services individually. But I include it in controller test cases result<img width="1666" alt="Screenshot 2024-12-09 at 16 43 59" src="https://github.com/user-attachments/assets/05a71a90-2b93-4636-ba62-9086c37ae8fb">

Additional gemfile:<br />
- Annotation: It's good to know what is the table fields belongs to particular model, easy to read and it's auto generated
- bullet: nice to have gem to make sure we don't use resource waste logic such as (N+1) query
- rubocop: one of the best gem for engineers to adhere good practice in rails code

