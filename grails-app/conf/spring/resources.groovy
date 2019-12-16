package spring

import facturation.UserPasswordEncoderListener

// Place your Spring DSL code here
beans = {

	passwordEncoder(org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder)

	userPasswordEncoderListener(UserPasswordEncoderListener)
}
