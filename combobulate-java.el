;;; combobulate-java.el --- Java mode support for Combobulate  -*- lexical-binding: t; -*-

;; Copyright (C) 2025  vkhashimoto

;; Author: vkhashimoto <me@vkhashimoto.dev>
;; Keywords:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;;

;;; Code:

(require 'combobulate-settings)
(require 'combobulate-navigation)
(require 'combobulate-manipulation)
(require 'combobulate-interface)
(require 'combobulate-rules)
(require 'combobulate-setup)

(defun combobulate-java-pretty-print-node-name (node default-name)
  "Pretty print the node name for Java mode."
  (pcase (combobulate-node-type node)
    (_ default-name)))

(eval-and-compile
  (defconst combobulate-java-definitions
    '(
      (procedures-sibling
       `((:activation-nodes
	  ((:nodes 
	    ((rule "block"))
	    :position at
	    :has-parent ("block")))
	  :selector (:choose
		     parent 
		     :match-children t)))))))

(define-combobulate-language
 :name java
 :language java
 :major-modes (java-ts-mode)
 :custom combobulate-java-definitions
 :setup-fn combobulate-java-setup)

(defun combobulate-java-setup (_))

(provide 'combobulate-java)



