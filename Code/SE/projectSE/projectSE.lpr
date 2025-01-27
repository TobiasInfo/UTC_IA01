(in-package :cg-user)

(define-project :name :|projectSE|
  :modules (list (make-instance 'module :name "main") (make-instance 'module :name "bdr")
                 (make-instance 'module :name "chainage_arriere")
                 (make-instance 'module :name "chainage_avant")
                 (make-instance 'module :name "fonctions_outil")
                 (make-instance 'module :name "getters")
                 (make-instance 'module :name "verif"))
  :projects nil
  :libraries nil
  :editable-files nil
  :distributed-files nil
  :internally-loaded-files nil
  :project-package-name :common-graphics-user
  :main-form nil
  :compilation-unit t
  :concatenate-project-fasls nil
  :verbose nil
  :runtime-modules (list :dde :cg.yes-no-string :cg.yes-no-list :cg.wrap-string
                         :cg.web-browser.dde :cg.web-browser :cg.utility-dialog
                         :cg.up-down-control :cg.tray :cg.trackbar :cg.touch :cg.tooltip
                         :cg.toolbar :cg.toggling-widget :cg.timer :cg.text-widget
                         :cg.text-or-combo :cg.text-edit-pane.mark
                         :cg.text-edit-pane.file-io :cg.text-edit-pane
                         :cg.template-string :cg.tab-control :cg.string-dialog
                         :cg.status-bar :cg.static-text :cg.split-bar :cg.shortcut-menu
                         :cg.selected-object :cg.scrolling-static-text
                         :cg.scroll-bar-mixin :cg.scroll-bar :cg.scaling-stream
                         :cg.sample-file-menu :cg.rich-edit-pane.printing
                         :cg.rich-edit-pane.clipboard :cg.rich-edit-pane :cg.rich-edit
                         :cg.radio-button :cg.property :cg.project-window
                         :cg.progress-indicator :cg.printing :cg.plot-widget :cg.player
                         :cg.pixmap.rotate :cg.pixmap.printing :cg.pixmap.file-io
                         :cg.pixmap-widget :cg.pixmap :cg.picture-widget.palette
                         :cg.picture-widget :cg.paren-matching :cg.palette
                         :cg.outline.edit-in-place :cg.outline.drag-and-drop :cg.outline
                         :cg.os-window :cg.os-widget :cg.ocx :cg.nodes
                         :cg.multi-picture-button.tooltip
                         :cg.multi-picture-button.drag-and-drop :cg.multi-picture-button
                         :cg.multi-line-lisp-text :cg.multi-line-editable-text
                         :cg.message-dialog :cg.menu.tooltip :cg.menu :cg.mci
                         :cg.list-view :cg.lisp-widget :cg.lisp-text :cg.lisp-edit-pane
                         :cg.lettered-menu :cg.layout :cg.lamp :cg.keyboard-shortcuts
                         :cg.item-list :cg.intersect.posbox :cg.intersect :cg.ie
                         :cg.icon-pixmap :cg.icon :cg.html-widget :cg.html-dialog
                         :cg.hotspot :cg.header-control :cg.group-box
                         :cg.grid-widget.drag-and-drop :cg.grid-widget
                         :cg.graphics-context :cg.get-position :cg.get-pixmap
                         :cg.gesture-emulation :cg.font-dialog :cg.find-string-dialog
                         :cg.fill-texture :cg.file-dialog :cg.editable-text
                         :cg.edit-in-place :cg.dropping-outline :cg.drawable.clipboard
                         :cg.drawable :cg.drag-and-drop-image :cg.drag-and-drop
                         :cg.directory-dialog-os :cg.directory-dialog :cg.dialog-item
                         :cg.curve :cg.cursor-pixmap :cg.comtab :cg.common-control
                         :cg.combo-box :cg.color-dialog :cg.clipboard.pixmap
                         :cg.clipboard-stack :cg.clipboard :cg.class-support
                         :cg.class-slot-grid :cg.choose-printer :cg.choice-list
                         :cg.check-box :cg.chart-widget :cg.chart-or-plot :cg.caret
                         :cg.calendar :cg.button :cg.bitmap-stream
                         :cg.bitmap-pane.clipboard :cg.bitmap-pane :cg.base
                         :cg-dde-utils)
  :splash-file-module (make-instance 'build-module :name "")
  :icon-file-module (make-instance 'build-module :name "")
  :include-flags (list :top-level :debugger)
  :build-flags (list :allow-runtime-debug :runtime-bundle)
  :autoload-warning nil
  :full-recompile-for-runtime-conditionalizations nil
  :include-manifest-file-for-visual-styles t
  :default-command-line-arguments "+M +t \"Console for Debugging\""
  :additional-build-lisp-image-arguments (list :read-init-files nil)
  :old-space-size 256000
  :new-space-size 6144
  :runtime-build-option :standard
  :build-number 0
  :run-with-console nil
  :project-file-version-info nil
  :save-whether-to-show-subproject-modules t
  :utility-file-directory nil
  :on-initialization 'default-init-function
  :default-error-handler-for-delivery 'report-unexpected-error-and-exit
  :on-restart 'do-default-restart
  :cgjs-options (make-instance 'cgjs-options :run-as-web-browser-server nil
                               :start-local-client t
                               :include-modules-for-starting-local-client t
                               :exit-server-on-client-exit t
                               :limit-connections-to-same-machine nil
                               :show-cgjs-server-window nil :cgjs-logging nil
                               :confirm-exit t :include-modules-for-cgjs-logging t
                               :browser-server-port nil :max-clients 1 :browser-keychords
                               (list "F11" "Control+Meta+F" "Control+0" "Control+-"
                                     "Control+=" "Control+Shift+-" "Control+Shift+="
                                     "Meta+0" "Meta+-" "Meta+=" "Meta+Shift+-"
                                     "Meta+Shift+=")
                               :title-for-browser-tab "Allegro Common Lisp"
                               :style-options nil))

;; End of Project Definition
