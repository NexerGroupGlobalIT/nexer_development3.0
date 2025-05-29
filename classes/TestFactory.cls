public class TestFactory {

    /*
    @description :  Creates a single sObject with default values (if specified in TestFactoryDefaults)
    @param :  SObject   sObj    Type of sObject to create.
    @return : SObject
    */
    public static SObject createSObject(SObject sObj) { 
        String objectName = String.valueOf(sObj.getSObjectType());
        String defaultClassName =objectName.replaceAll('__(c|C)$|__', '') + 'Defaults';//Eg. Account-->AccountDefaults,Test__c-->TestDefaults
        return sObj;
    }

    /*
    @description : Creates a single sObject with default values (if specified in TestFactoryDefaults)
    @param :  SObject  sObj      Type of sObject to create.
    @param :  Boolean  doInsert  should this object be inserted?
    @return :  SObject
    */
    public static SObject createSObject(SObject sObj, Boolean doInsert) {
        SObject retObject = createSObject(sObj);
        if (doInsert) {
            insert retObject;
        }
        return retObject;
    }
    

    /**
     * @description Internal custom exception class
     */
    public class TestFactoryException extends Exception {
    }

}