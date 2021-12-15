# creator: abmathewks/CreateProjectFiles.R
# Date 2021-12-14

CreateProjectFiles <- function(PROJECT_PATH = rstudioapi::getActiveProject(),
                               FOLDERS_TO_CREATE = c("data", "docs", "figs", "logs",
                                                     "output", "queries", "R", "tests"),
                               OPEN_NEW_SESSION = TRUE,
                               DEBUG = TRUE){

    if(DEBUG) message("CreateProjectFiles: Function initialized  \n")
  
    if(!dir.exists(PROJECT_PATH)){
        stop("CreateProjectFiles: Project path does not exist  \n")
    }
  
    if(!getwd() == PROJECT_PATH){
        stop("CreateProjectFiles: Project path argument is different from the current working directory  \n")
    }
  
    FUNCTION_OUTPUT <- list()
  
    FUNCTION_OUTPUT[["CURRENT_DIRECTORY"]] <- getwd()
    FUNCTION_OUTPUT[["PROJECT_PATH"]] <- PROJECT_PATH
    FUNCTION_OUTPUT[["DIRECTORY_EXISTS"]] <- dir.exists(PROJECT_PATH)
    FUNCTION_OUTPUT[["RPROJ_FILE_PRESENT"]] <- any(grepl("Rproj", list.files()))
    FUNCTION_OUTPUT[["FOLDERS_PRESENT_ORIG"]] <- all(FOLDERS_TO_CREATE %in% list.files(PROJECT_PATH))
  
    if(!any(grepl("Rproj", list.files()))){
  
        if(DEBUG) message("CreateProjectFiles: Project is not present  \n")
  
        usethis::create_project(PROJECT_PATH, open = OPEN_NEW_SESSION)
  
    }
  
    if(!all(FOLDERS_TO_CREATE %in% list.files(PROJECT_PATH))){
  
        if(DEBUG) message("CreateProjectFiles: Creating files  \n")
  
        for(each_folder in FOLDERS_TO_CREATE){
  
          dir.create(file.path(PROJECT_PATH, each_folder), showWarnings = FALSE)
  
          if(each_folder == "data"){
  
             dir.create(file.path(PROJECT_PATH, each_folder, "raw"), showWarnings = FALSE)
             dir.create(file.path(PROJECT_PATH, each_folder, "processed"), showWarnings = FALSE)
  
           }
       }
    } else {
  
        if(DEBUG) message("CreateProjectFiles: FOLDERS_TO_CREATE already present in the PROJECT_PATH  \n")
      
    }
  
    FUNCTION_OUTPUT[["FOLDERS_PRESENT_NEW"]] <- all(FOLDERS_TO_CREATE %in% list.files(PROJECT_PATH))
    FUNCTION_OUTPUT[["OPEN_NEW_SESSION"]] <- OPEN_NEW_SESSION
  
    if(all(FOLDERS_TO_CREATE %in% list.files(PROJECT_PATH))){
        if(DEBUG) message("CreateProjectFiles: Function run completed  \n")
  
        return(FUNCTION_OUTPUT)
    } else {
        stop("CreateProjectFiles: Folders not created  \n")
    }
}

