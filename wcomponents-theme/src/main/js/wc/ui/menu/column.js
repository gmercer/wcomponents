/**
 * Menu controller extension for WMenu of type COLUMN. This represents a vertical menu with optional flyout submenus.
 *
 * @see {@link http://www.w3.org/TR/wai-aria-practices/#menu}
 * @module
 * @extends module:wc/ui/menu/core
 * @requires module:wc/ui/menu/core
 * @requires module:wc/dom/keyWalker
 * @requires module:wc/dom/shed
 * @requires module:wc/dom/Widget
 * @requires module:wc/dom/initialise
 */
define(["wc/ui/menu/core", "wc/dom/keyWalker", "wc/dom/shed", "wc/dom/Widget", "wc/dom/initialise", "wc/ui/menu/menuItem"],
	/** @param abstractMenu @param keyWalker @param shed  @param Widget @param initialise @ignore */
	function(abstractMenu, keyWalker, shed, Widget, initialise) {
		"use strict";

		/* Unused dependencies:
		 * We will need ["wc/ui/menu/menuItem" if we have any selectable items so we get it just in case rather than doing a
		 * convoluted XPath lookup in XSLT.
		 */

		/**
		 * Extends menu functionality to provide a specific implementation of a vertical menu with optional flyout sub-menus.
		 * @constructor
		 * @alias module:wc/ui/menu/column~Column
		 * @extends module:wc/ui/menu/core~AbstractMenu
		 * @private
		 */
		function Column() {
			/**
			 * The descriptors for this menu type.
			 * @type {module:wc/dom/Widget}
			 * @protected
			 * @override
			 */
			this._wd = {};

			/**
			 * The {description of the ROOT node of a column menu.
			 * @type {module:wc/dom/Widget}
			 * @public
			 * @override
			 */
			this.ROOT = new Widget("", "wc-menu-type-column");

			/**
			 * Reset the key map based on the type and/or state of the menu item passed in.
			 *
			 * @function
			 * @protected
			 * @override
			 * @param {Element} item The menu item which has focus.
			 */
			this._remapKeys = function(item) {
				var element = item,
					root = this.getRoot(item);

				if (!root) {
					return;
				}
				if (this._isBranchOrOpener(element)) {
					element = this._getBranchExpandableElement(element);
					if (!shed.isExpanded(element)) {
						this._keyMap["DOM_VK_RIGHT"] = this._FUNC_MAP.ACTION;
					} else {
						this._keyMap["DOM_VK_RIGHT"] = keyWalker.MOVE_TO.CHILD;
					}
				}
			};

			/**
			 * Sets up the initial keymap for column menus as per {@link http://www.w3.org/TR/wai-aria-practices/#menu}.
			 *
			 * @function
			 * @protected
			 * @override
			 */
			this._setupKeymap = function() {
				this._keyMap = {
					"DOM_VK_UP": keyWalker.MOVE_TO.PREVIOUS,
					"DOM_VK_DOWN": keyWalker.MOVE_TO.NEXT,
					"DOM_VK_LEFT": this._FUNC_MAP.CLOSE_MY_BRANCH,
					"DOM_VK_ESCAPE": this._FUNC_MAP.CLOSE_MY_BRANCH
				};
			};
		}

		var /** @alias module:wc/ui/menu/column */instance;
		Column.prototype = abstractMenu;
		instance = new Column();
		instance.constructor = Column;
		initialise.register(instance);
		return instance;
	});
