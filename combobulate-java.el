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
      (procedure-discard-rules '("line_comment" "block_comment"))
      (procedures-sibling
       `(
	 (:activation-nodes
	  ((:nodes 
	    ((rule "method_invocation"))
	    :position at
	    :has-ancestor ("block")))
	  :selector (:choose
		     parent 
		     :match-children t))
	 (:activation-nodes
	  ((:nodes 
	    ((rule "element_value_pair"))
	    :position at
	    :has-ancestor ("annotation_argument_list")))
	  :selector (:choose
		     parent
		     :match-children t))
	 (:activation-nodes
	  ((:nodes 
	    ((rule "formal_parameters"))
	    :position at))
	  :selector (:choose
		     node
		     :match-siblings t))
	 (:activation-nodes
	   ((:nodes 
	     (("import_declaration" "package_declaration" "class_declaration"))
	     :position at
	     :has-parent ("program")))
	   :selector (:choose
		      parent
		      :match-children t))
	 (:activation-nodes
	  ((:nodes 
	    ((rule "class_body"))
	    :position at))
	  :selector (:choose
		     node
		     :match-siblings t))
	 (:activation-nodes
	  ((:nodes 
	    ((rule "expression_statement") (irule "type_identifier"))
	    :position at
	    :has-ancestor ("constructor_body")))
	  :selector (:choose
		     parent 
		     :match-children t))
	 (:activation-nodes
	  ((:nodes 
	    (("type_identifier"))
	    :position at
	    :has-parent ("type_arguments")))
	  :selector (:choose
		     node
		     :match-siblings t))
)))))

(define-combobulate-language
 :name java
 :language java
 :major-modes (java-mode java-ts-mode)
 :custom combobulate-java-definitions
 :setup-fn combobulate-java-setup)

(defun combobulate-java-setup (_))

(provide 'combobulate-java)
