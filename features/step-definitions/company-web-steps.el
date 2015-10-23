(When "^I execute company-web prefix command at current point$"
      (lambda ()
        (setq company-web-test-prefix-output
              (company-web-html 'prefix))))

(When "^I execute company-web post-completion with \"\\(.*\\)\""
      (lambda (str)
        (company-web-html 'post-completion str)))

(Then "^company-web prefix is\\(?: \"\\(.*\\)\"\\|:\\)$"
      (lambda (expected)
        (should (equal company-web-test-prefix-output expected))))

(Then "^company-web prefix none$"
      (lambda ()
        (should (not company-web-test-prefix-output))))

(When "^I execute company-web candidates command at current point$"
      (lambda ()
        (let* ((tmp (or (company-web-html 'prefix) 'stop))
               (prefix (if (consp tmp) (car tmp) tmp)))
          (when (not (eq prefix 'stop))
            (setq company-web-test-candidates-output
                  (mapcar (lambda (s) (substring-no-properties s))
                          (company-web-html 'candidates prefix)))))))

(Then "^company-web-html candidates are\\(?: \"\\(.*\\)\"\\|:\\)$"
      (lambda (expected)
        (should (equal company-web-test-candidates-output (read expected)))))

(Then "^company-web-html candidates contains\\(?: \"\\(.*\\)\"\\|:\\)$"
      (lambda (expected)
        (should (member expected company-web-test-candidates-output))))

(Then "^company-web-html candidates not contains\\(?: \"\\(.*\\)\"\\|:\\)$"
      (lambda (expected)
        (should (not (member expected company-web-test-candidates-output)))))