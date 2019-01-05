(in-package :cl-user)
(defpackage cl-project.middleware
  (:use #:cl)
  (:import-from #:cl-project.file
                #:template-file-path)
  (:export #:*without-tests*
           #:*without-makefile*))
(in-package :cl-project.middleware)

(defparameter *without-tests*
  (lambda (app &key
            (test-asd "skeleton-test.asd")
            (test-directory #P"t/"))
    (lambda (file)
      (unless (or
               ;; Skip test ASD file
               (string= (file-namestring (template-file-path file))
                        test-asd)
               ;; Skip test files
               (eql 0 (search (namestring test-directory)
                              (namestring (template-file-path file)))))
        (funcall app file)))))

(defparameter *without-makefile*
  (lambda (app &key (makefile-name "Makefile"))
    (lambda (file)
      (unless (string= (file-namestring (template-file-path file))
                       makefile-name)
        (funcall app file)))))
