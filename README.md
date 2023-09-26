# E-Healthcare Management System

![home page](output\homepage.png)

## Introduction

The E-Healthcare Management System is a web-based application developed using Java, JSP, Servlets, HTML, CSS, JDBC, and MySQL. This system is designed to streamline and improve the management of healthcare-related processes, making it easier for both patients and doctors to interact and manage their healthcare needs efficiently.

## Features

### 1. User Authentication
- Users can register and log in with their credentials.
- User types include patients and doctors, each with their specific functionalities.

### 2. Patient Features
- Patients can schedule appointments with doctors.
- View and manage their medical reports.
- Provide feedback and ratings for healthcare services.

### 3. Doctor Features
- Doctors can view their appointment schedules.
- Access patient medical reports.
- Update appointment statuses and fees.
- View patient feedback and ratings.

## Output screens

#### login form
![login](output\loginform.png)
#### Booking Appointment
![patient profile](output\appointment-booking.png)
#### Patient Profile
![patient profile](output\patient.png)
#### Doctor profile
![doctor profile](output\doctor.png)
#### Add doctor
![Add doctor](output\add-doctor.png)
#### Remove doctor
![remove doctor](output\remove-doctor.png)
#### Patient Feedback
![patient feedback](output\give-feedback.png)
#### Admin portal
![admin profile](output\admin.png)
#### Admin: View reports
![view reports: Admin](output\admin-reports.png)




## Technologies Used

- **Java**: The core programming language used for server-side logic.
- **JSP (JavaServer Pages)**: Used to create dynamic web pages.
- **Servlets**: Handle HTTP requests and responses.
- **HTML/CSS**: For the user interface and styling.
- **JDBC (Java Database Connectivity)**: To connect and interact with the MySQL database.
- **MySQL**: The relational database management system used for storing data.

## Database Schema

The database schema consists of several tables to manage different aspects of the E-Healthcare system:

1. **users**: Stores user information for authentication.
2. **doctors**: Contains details about doctors.
3. **patients**: Stores patient information.
4. **appointments**: Manages appointments between patients and doctors.
5. **Reports**: Stores medical reports associated with appointments.
6. **feedback**: Collects patient feedback and ratings.

## Getting Started

To set up and run the E-Healthcare Management System, follow these steps:

1. **Database Setup**: Create a MySQL database and run the provided SQL scripts to create the necessary tables.

2. **Project Setup**: Import the project into your Java IDE and configure the JDBC connection to your MySQL database.

3. **Run the Application**: Deploy the application on a servlet container (e.g., Apache Tomcat) and start the server.

4. **Access the Application**: Open a web browser and navigate to the application's URL to start using it.

## Usage

- Patients can log in, schedule appointments, view medical reports, and provide feedback.
- Doctors can log in, manage appointments, access patient reports, and view feedback.
- Users (both patients and doctors) can update their profiles and passwords.