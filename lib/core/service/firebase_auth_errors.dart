String fireBaseAuthError(String code) {
  switch (code) {
    
    case 'user-not-found':
      return 'No user found for that email.';
    case 'wrong-password':
      return 'Wrong password provided for that user.';
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'user-disabled':
      return 'This user has been disabled.';
    case 'too-many-requests':
      return 'Too many requests. Please try again later.';
    case 'operation-not-allowed':
      return 'This operation is not allowed. Please contact support.';
    
    
    case 'email-already-in-use':
      return 'The email address is already in use by another account.';
    case 'weak-password':
      return 'The password is too weak. Please choose a stronger password.';
    case 'invalid-password':
      return 'The password is invalid. Please choose a valid password.';
    
    
    case 'auth/invalid-verification-code':
      return 'Invalid verification code.';
    case 'auth/expired-action-code':
      return 'The verification code has expired.';
    case 'auth/invalid-action-code':
      return 'Invalid action code.';
    case 'auth/account-exists-with-different-credential':
      return 'An account already exists with a different credential.';
    case 'auth/email-already-in-use':
      return 'The email address is already in use by another account.';
    
    
    case 'auth/invalid-credential':
      return 'Invalid credentials. Please try again.';
    case 'auth/missing-credential':
      return 'Credentials are missing. Please sign in again.';
    case 'auth/invalid-api-key':
      return 'Invalid API key. Please check the configuration.';
    
    default:
      return 'An unknown error occurred. Please try again.';
  }
}
