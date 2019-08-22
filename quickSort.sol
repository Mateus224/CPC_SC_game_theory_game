
pragma solidity ^0.4.24;


contract SortArray{

    //int16[] SortedArray;

    //function getSortedArray()public constant returns(uint16[]){
    //   return SortedArray;
    //}

    function sort(uint16[] data) public constant returns(uint16[]) {
       quickSort(data, int16(0), int16(data.length - 1));
       //SortedArray=data;
       return data;
    }
    
    //quickSort is a recusive fast Sorting algorithm || maybe to realize it as library
    function quickSort(uint16[] memory arr, int16 left, int16 right) internal{
        int16 i = left;
        int16 j = right;
        if(i==j) return;
        uint pivot = arr[uint(left + (right - left) / 2)];
        while (i <= j) {
            while (arr[uint(i)] < pivot) i++;
            while (pivot < arr[uint(j)]) j--;
            if (i <= j) {
                (arr[uint(i)], arr[uint(j)]) = (arr[uint(j)], arr[uint(i)]);
                i++;
                j--;
            }
        }
        if (left < j)
            quickSort(arr, left, j);
        if (i < right)
            quickSort(arr, i, right);
    }
}
