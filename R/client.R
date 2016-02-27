save.credentials <- function(user, pass) {
  if (user != "" && pass != "") {
    assign("NS_USER", user, envir=auth_cache)
    assign("NS_PASS", pass, envir=auth_cache)
  } else {
    message("No credentials found, please load them with save.credentials(user, pass)")
  }
}