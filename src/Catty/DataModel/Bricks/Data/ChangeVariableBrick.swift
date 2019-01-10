/**
 *  Copyright (C) 2010-2018 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

class ChangeVariableBrick: Brick, BrickFormulaProtocol, BrickVariableProtocol {
    var userVariable: UserVariable?
    var variableFormula: Formula?
    
    func formula(forLineNumber lineNumber: Int, andParameterNumber paramNumber: Int) -> Formula? {
        return variableFormula
    }
    
    func setFormula(_ formula: Formula?, forLineNumber lineNumber: Int, andParameterNumber paramNumber: Int) {
        variableFormula = formula
    }
    
    func variable(forLineNumber lineNumber: Int, andParameterNumber paramNumber: Int) -> UserVariable? {
        return userVariable
    }
    
    func setVariable(_ variable: UserVariable?, forLineNumber lineNumber: Int, andParameterNumber paramNumber: Int) {
        userVariable = variable
    }
    
    func getFormulas() -> [Formula]? {
        return [variableFormula!]
    }
    
    override func setDefaultValuesFor(_ spriteObject: SpriteObject?) {
        variableFormula = Formula(integer: 1)
        if spriteObject != nil {
            let variables = spriteObject?.program?.variables.allVariables(for: spriteObject)
            if (variables?.count ?? 0) > 0 {
                userVariable = variables?[0] as? UserVariable
            } else {
                userVariable = nil
            }
        }
    }
    
    func brickTitle() -> String? {
        return kLocalizedChangeVariable + ("\n%@\n" + (kLocalizedBy + ("%@")))
    }
    
    func allowsStringFormula() -> Bool {
        return true
    }
    
    // MARK: - Description
    
    override func description() -> String {
        if let aVariable = userVariable {
            return "Change Variable Brick: Uservariable: \(aVariable)"
        }
        return ""
    }
    
    override func isEqual(to brick: Brick?) -> Bool {
        if !(userVariable?.isEqual(to: (brick as? ChangeVariableBrick)?.userVariable) ?? false) {
            return false
        }
        if !(variableFormula?.isEqual(to: (brick as? ChangeVariableBrick)?.variableFormula) ?? false) {
            return false
        }
        return true
    }
    
    // MARK: - Resources
    
    override func getRequiredResources() -> Int {
        return variableFormula?.getRequiredResources() ?? 0
    }
}
