# Spec: User Login Requirements

## User Story

As a registered user of the platform,  
I want to log in using my email and password,  
So that I can receive an access token to use the secure APIs.

## Requirements

1. **Endpoint:** Expose a `POST /api/auth/login` endpoint.
2. **Payload:** Accept a JSON body containing `email` (string, valid email) and `password` (string).
3. **Authentication:**
   - Find the user record matching the provided email.
   - Verify the password hash against the stored hash using bcrypt.
4. **Responses:**
   - Return `200 OK` with `accessToken` and `refreshToken` on success.
   - Return `401 Unauthorized` on incorrect email or password.
   - Return `400 Bad Request` if payload validation fails.
