--{-# LANGUAGE NoMonomorphismRestriction #-}
import System.Directory
import Prelude;
import Data.List
import Data.Tuple(swap)
import Data.Ord
import Data.Maybe
import Data.Text(splitOn,pack,unpack)
import System.Environment  as Env

fileExtension f = xs !! (length xs-1)
  where xs = mySplit "." f

insertPostfixToFilename f p = name++ p ++"."++extension
	where
		[name,extension]= mySplit "." f

mySplit d s= map unpack $ splitOn (pack d) (pack s)

splitCsvColumns = mySplit ","
joinCsvColumns = intercalate ","

selectIndexes indexes xs = map  ( xs !!) indexes

processCols indexes excludedValues  cols | any = Nothing
                            | otherwise = Just (selectIndexes indexes cols) 
                            where any = and (map f excludedValues)
                                  f (i,v) = cols !! i /= v
                                  
svmlCN = selectLinesAndColumns [13,7,2,0] [(3,"0.85")]
svmlCC = selectLinesAndColumns [13,0,7,2] [(3,"128")]

--percentTest,n,hidden,tr,te   
ffCN = selectLinesAndColumns [4,2,1,0] [(3,"0.70")]
ffCC = selectLinesAndColumns [4,0,2,1] [(3,"16")]

--percentTest,angles,n,normalize,smoothingWindowSize,rotate,datasetId,spread,groupSize,Tr,Tr(sd),Te,Te(sd)
gmm = selectLinesAndColumns [11,0,2,7] [(3,"16")]


svmgCN = selectLinesAndColumns [13,7,2,0,9] [(3,"0.85"),(4,"128")]
svmgCS = selectLinesAndColumns [13,7,9,0,2] [(3,"0.85"),(4,"128")]
svmgCC = selectLinesAndColumns [13,0,7,2,9] [(3,"128"),(4,"128")]

processes = [
            (gmm,"gmm-lnhg.csv","gmm-lnhg-cc.csv"),
            (ffCN,"ff-lnhg.csv","ff-lnhg-cn.csv"),
            (ffCC,"ff-lnhg.csv","ff-lnhg-cc.csv"),
            (svmlCN,"svml-lnhg.csv","svml-lnhg-cn.csv"),
            (svmlCC,"svml-lnhg.csv","svml-lnhg-cc.csv"),
            (svmgCN,"svmg-lnhg.csv","svmg-lnhg-cn.csv"),
            (svmgCS,"svmg-lnhg.csv","svmg-lnhg-cs.csv"),
            (svmgCC,"svmg-lnhg.csv","svmg-lnhg-cc.csv")
            ]

main = do
    mapM_ readWriteFileDestination processes



splitHeader s = (x,unlines xs)
              where (x:xs) = lines s

selectLinesAndColumns columns excludedValues s= h++ "\n" ++ (selectLines  p ds)  
                                            where s'= selectColumns columns s
                                                  p= allColumnsWithValues excludedValues
                                                  (h,ds) = splitHeader s' 

                                                   
selectColumns' lines columns = map (joinCsvColumns . selectIndexes columns . splitCsvColumns) lines
selectColumns columns s = unlines $ selectColumns' (lines s) columns

selectLines  p s = unlines $ filter p (lines s)

allColumnsWithValues values line  = and (map f values)
                   where   f (i,v) = (line' !! i) == v
                           line' = splitCsvColumns line


            
readWriteFileDestination (f, source, destination) = do
	s <- readFile source
	writeFile destination $ f s



        
--processByLinesAndColumns f file destination = processByLines file destination ( (maybe Nothing (Just . joinCsvColumns)) . f . splitCsvColumns )
--processByLines f select = readWriteFile  (  unlines  . (mapMaybe f) . select lines)


--readWriteFile f = do
--	[source] <- getArgs
--	s     <- readFile source
--	writeFile (insertPostfixToFilename source "-plot") $ (f s)


--processFiles directory f = mapM f (getDirectoryContents directory)
		

--main = do
      --[directory] <- getArgs
      --files <- getDirectoryContents directory
      --mapM_ (processFile id ) $ prependAll (directory++"\\") (removeWindowsPaths files)

--removeWindowsPaths files = filter (/=".") $ filter (/="..") files
--prependAll prefix xs = map (prefix ++) xs

--selectFunction filename = functionsF (getPrefix filename)

--functionsF "ff" = ffCN
--functionsCC "ff" = ffCN 

--getPrefix filename = "asd"
 
--processFile f source  = do
	--s     <- readFile source
	--writeFile (source++"asd")  (f source s)
        
