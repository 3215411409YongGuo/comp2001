### Trail Service Microservice Implementation

----

## **Project Overview**

This project is part of the coursework for the COMP2001 Information Management & Retrieval module. It focuses on developing a Trail Service microservice to provide core support for a trail application. The microservice enables Create, Read, Update, and Delete (CRUD) operations on trail data, allows users to view trail information, and adheres to the RESTful API principles to ensure standardized and efficient data interaction.****

----

## **Functional Features**

- **Trail Data Management**: Achieves comprehensive management of trail data, including creation, reading, updating, and deletion operations. Users can conveniently manipulate trail information through the API, such as adding new trails, querying specific trail details, modifying existing trail data, and deleting unnecessary trail records.
- **User Permission Control**: Imposes reasonable restrictions on trail viewing permissions. Ordinary users can only browse basic trail information, safeguarding data security and privacy and preventing the leakage of sensitive information.
- **Data Association and Presentation**: Establishes associations between trails and users, clarifying the ownership of trails. Additionally, it can effectively integrate and display key information such as trail location points, providing users with intuitive and accurate trail details.

----

## **Technical Implementation**
- **Database**: Microsoft SQL Server is selected as the database management system and is deployed on the server dist-6-505.uopnet.plymouth.ac.uk. The database schema is meticulously designed, consisting of multiple entity tables such as the trail table and user table. Appropriate foreign key constraints are used to establish relationships between tables, ensuring data integrity and consistency. Stored procedures are utilized to implement efficient data operation logic, enhancing the reliability and maintainability of data processing. Triggers are employed to automatically record trail addition operations for subsequent auditing and tracking.
- **Server - side Code**:  The server - side code is developed using Python and deployed on the server web.socem.plymouth.ac.uk. Leveraging rich Python libraries and frameworks such as Flask or Django (depending on the actual selection), a stable and efficient API service is built. It strictly adheres to the RESTful API design principles, ensuring the standardization and universality of the interface, facilitating integration with other microservices or front - end applications.
- **API Documentation**: Swagger is used to generate detailed API documentation, clearly presenting crucial information such as the functions of each API endpoint, request parameters, and response formats. This provides developers with an intuitive and accurate guide for interface calls, reducing integration difficulties and improving development efficiency.

----

## **Project Structure**  

````
project/
│
├── app/
│   ├── models/         # Store code related to data models, such as SQLAlchemy model definitions (if used)
│   ├── routes/         # Define API routes to handle different HTTP requests
│   ├── utils/          # Auxiliary functions and utility classes, such as database connection functions and data validation tools
│   ├── main.py         # The main application entry point, initializing the application and configuration
│
├── tests/              # Unit test and integration test code to ensure the normal operation of each functional module
│
├── requirements.txt    # List of project - dependent libraries, specifying the Python libraries and versions required for the project to run
│
└── README.md           # The current project description document
````

----

## **Usage Instructions**
- **Environment Configuration**: Set up a development environment locally, install Python and the project - required dependent libraries. You can quickly install them using the command pip install -r requirements.txt. Ensure that the database connection information, including the server address, port, username, and password, has been correctly configured.
- **Running the Project**:Execute the command python app/main.py in the project root directory to start the service. After the service is started, you can access the API interface through the Swagger documentation. The address is usually http://localhost:5000/swagger (the specific port depends on the actual configuration). On the Swagger page, you can intuitively view the detailed information of each API endpoint and conduct online tests.
- **API Call Example**: Taking the retrieval of trail information as an example, use a GET request to access the /api/trails/{trail_id} endpoint. Replace {trail_id} with the actual trail ID to obtain the detailed information of the corresponding trail. The response data is returned in JSON format, facilitating parsing and display by front - end applications.

---

## **Contributors**

Yong Guo - Responsible for the overall design, development, and testing of the project, covering key aspects such as database design, server - side code writing, API interface implementation, and test case writing.

---

## **Acknowledgments**

Thanks to the instructors of the COMP2001 course, Haoyi Wang and Martin Read, for their careful guidance and valuable suggestions during the course study and project development, which have provided strong support for the smooth progress of the project.
