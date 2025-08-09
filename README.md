# Secure GDrive Link Encryptor and Decryptor (FastAPI Version)

This project helps you to securely share **Google Drive files** by encrypting the file link using a **10-digit password**. The encrypted link is shared with recipient, and they can decrypt it using a simple **web interface**.

This version is built using **FastAPI**, replacing the earlier version that used **Flask**.

For the **Flask** version you can visit:  
- https://github.com/dasher06/Secure_Gdrive_File

---

## What Happens in the Project ?

1. You take a **Google Drive file link** and encrypt it with a **10-digit password**.

2. The app generates a secure **encrypted string** representing your original link.

3. You share the **encrypted string** via a **URL** through any communication channel.

4. The recipient opens the **decryption page** to input the encrypted string and password.

5. If the password is correct, the original **Google Drive link** is instantly revealed.

6. The app runs as a containerized **FastAPI** service for scalability and **cloud deployment**.


---

## How to Run the Project Locally

### Steps

1. **Clone this repository**:
   ```bash
   git clone https://github.com/your-username/Secure_Link_Decryptor_FastAPI.git
   cd Secure_Link_Decryptor_FastAPI
   ```

2. **Install the required Python packages**:
   ```bash
   pip install -r requirements.txt
   ```

3. **Start the FastAPI server**:
   ```bash
   uvicorn decrypt_api:app --reload
   ```

4. **Open in browser**:
   - Go to `http://127.0.0.1:8000/decrypt_link`

---

## How to Deploy on Google Cloud Run

1. Create a **Google Cloud Project** and enable:
   - Cloud Run
   - Cloud Build
   - Artifact Registry

2. **Install Google Cloud CLI** and log in:
   ```bash
   gcloud auth login
   gcloud config set project [PROJECT_ID]
   ```

3. **Submit your app for deployment**:
   ```bash
   gcloud builds submit --tag gcr.io/[PROJECT_ID]/secure-gdrive-fastapi
   gcloud run deploy secure-gdrive-fastapi \
       --image gcr.io/[PROJECT_ID]/secure-gdrive-fastapi \
       --platform managed \
       --region [YOUR_REGION] \
       --allow-unauthenticated
   ```

4. Once deployed, you’ll get a public link to use like this:
   - `https://secure-gdrive-fastapi-xxxxxx.run.app/decrypt_link?encrypted=...`

Share this URL along with the password.

---

## How to run using Docker

You can run this FastAPI service inside Docker for easy local testing or deployment.

### 1. Build the Docker Image

```bash
docker build -t dockerized-fastapi-link-encryptor-decryptor .
```

### 2. Run the Container

```bash
docker run -d \
  --name dockerized-fastapi-link-encryptor-decryptor \
  -p 8080:8080 \
  dockerized-fastapi-link-encryptor-decryptor
```

The application will be accessible at:

- `Local: http://127.0.0.1:8080/decrypt_link`

### 3. Stop & Remove the Container

```bash
docker stop dockerized-fastapi-link-encryptor-decryptor && docker rm dockerized-fastapi-link-encryptor-decryptor
```

### 4. Development Mode with Auto-Reload

If you want the app to auto-reload on code changes:

```bash
docker run -it --rm \
  -v $(pwd):/app \
  -p 8080:8080 \
  dockerized-fastapi-link-encryptor-decryptor \
  uvicorn decrypt_api:app --host 0.0.0.0 --port 8080 --reload
```

---

## Docker Usage 

This repository includes a fully configured **Dockerfile** and **.dockerignore**, which are integral to both local development and cloud deployment workflows.

The **Docker** resources enable you to:

- Build and run the application in an isolated containerized environment.
- Ensuring consistent behavior across different systems.
- Test the application locally, replicating the exact conditions of the production environment.
- Deploy it directly to Google Cloud Run using the gcloud builds submit command.
  
By using **Docker**, you eliminate **“it works on my machine”** issues, streamline the development process, and validate your application before pushing it to the **cloud**.

---

## How I Ran the Project (Deployment Steps)

### 1. Localhost (Basic Testing)

Initially, I ran the Python application locally on my machine for basic testing.

I opened a terminal and executed:
```bash
uvicorn decrypt_api:app --reload
```

This started the web server at:

- `http://127.0.0.1:5000/decrypt_link`

This setup was sufficient for local testing, but access was limited to my machine only.

---

### 2. Ngrok (Temporary Public Access)

To enable temporary **public access**, I used **ngrok**.

After installing it, I ran the following command:
```bash
ngrok http 5000
```

**Ngrok** provided a public-facing URL **(please note: these links are no longer active)**:

- `https://secure-decryptor-1068809376566.us-central1.run.app/decrypt_link?encrypted=gAAAAABoV_6h-28TYpIJehShsPnfESGRAaXWLMhSsXC1kfINaxaL-4dPT1Lsuba7OSvJgk0U5XgpXLmKuAXPBqmA6ap5m-MH_66UW9HMQ117N1HHpWDRmuPTJxCwfYj0bTX_uW1CsfHr8nXQo_Vm6_1rvn4NWvOwYpBj92HyepVK4PC_rDYZ6J8=`


This allowed anyone with the link to access the web page. 

However, my local terminal had to remain active, and the HTTPS certificate provided by ngrok was self-signed, which may trigger browser security warnings.

---

### 3. Render (Permanent Public Access)

Later, I deployed the application to **Render.com**, a free hosting platform for web apps.

I pushed my code to GitHub and connected the repository to Render for **automatic deployment**.

Although **Render** successfully built and deployed the application:
- It introduced significant changes to the code and output.
- The **original logic** was altered in several areas, which was not ideal for this project.

Here’s an example of a Render-generated URL **(note: link is no longer active)**:

- `https://encryptedlinkapp.onrender.com/decrypt_link?encrypted=gAAAAABoVWml-d0XY_H9foOHshdv4WE11_l7Bony0O2AGPYcKtF2UfE49_8yMbcEyJKKtv8W1KnRuDOF47_hP-oMBWQqYlf4bLy-nicouNw_IT5HVfU3dBHimdZ9KrW5CgEczV3GA3CK86yHihpxrrjmjz4pR83AFQ==`

Even though this made the application publicly available 24/7, the deployment compromised the integrity of the original code.

---

### 4. Google Cloud Platform (Current Deployment using FastAPI)

Currently, the project is deployed on **Google Cloud Platform (GCP)** using **Cloud Run**, specifically to avoid the **code alterations** that occurred with **Render**.

I created a **Dockerfile** for the FastAPI app, but used the **gcloud CLI** to build and deploy it via **Google Cloud Build**, which handled the **containerization** automatically.

Here’s a sample live deployment link that opens a google drive file saying **HELLO!** as an example:

🔓 Decryption Page:

- https://fastapi-docker-decryptor-1068809376566.us-central1.run.app/decrypt_link?encrypted=gAAAAABolyk2PApRSLR4FoBYM5UlfS6TAgz5kPWP2-1DGgOIZBDRc7fQnLdc34f49SVkNao032QmtAb7Ea2iF0Rceir2dqPTiKZbUG_sVDe8vgF5hY_QwBShVev1tVzT_SvmhvI3eDZCCJ9-NREhV5XVdVl4XtHKhCkga3QeEhfj-oMi1gwnKeQ=

When prompted, enter the decryption key:

🔐 Decryption Key: 

- **1234567890**

This approach has proven to be the most **effective**. The server is live 24/7, and I was able to deploy the application without any **code modifications** or **runtime errors**.

---

## What's in the Project

- `decrypt_api.py`: The FastAPI application for link decryption
- `requirements.txt`: Python packages needed to run the app
- `templates/decrypt_link.html`: The form where users paste their encrypted link and key
- `Dockerfile`: Helps in building the app if needed (used by Cloud Build)
- `.dockerignore`: Prevents unnecessary files from going into the Docker image
- `.gitignore`: Keeps sensitive or unnecessary files out of version control

---

## Technologies Used

- Python 3 (Core programming language)
- FastAPI (Modern, fast web framework for API development)
- Cryptography (Fernet symmetric encryption for secure link encryption/decryption)
- Jinja2 (Template engine for rendering HTML pages)
- Uvicorn (ASGI server for running FastAPI locally and in production)
- Google OAuth 2.0 (Authentication and authorization for Google Drive API access)
- Google Drive API (To validate and interact with Google Drive links)
- Docker (Containerization for easy deployment and environment consistency)
- Google Cloud Platform (Cloud Run or similar service for hosting and deployment)
- Git and GitHub (Version control and code repository management)

---

## Acknowledgements

Special thanks to my uncles **Kiru Veerappan** and **Udhayan Nagarajan** for encouraging and guiding me in building this project .

---

Created by **Trinab Shan**  
GitHub: [@dasher06](https://github.com/dasher06)






