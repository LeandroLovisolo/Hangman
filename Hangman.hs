import System.Environment   
import Control.Monad
import Data.Char

main = do
    args  <- getArgs
    stdio <- getContents
    if wrongNumberOfArgs args || invalidCharacters args
        then printHelp
        else solvePuzzle (map toLower $ head args)
                         (if length args == 1 then "" else map toLower $ args !! 1)
                         (getDict stdio)
    where
        wrongNumberOfArgs args = not $ (length args) `elem` [1,2]
        invalidCharacters args = not $ null $ filter (\c -> not $ c `elem` '_':['a'..'z'])
                                                     (map toLower $ join args)

getDict :: String -> [String]
getDict s = filter validWord $ words $ map toLower s
    where validWord w = all validChar w
          validChar c = c `elem` ['a'..'z']

solvePuzzle :: String -> String -> [String] -> IO ()
solvePuzzle puzzle guessed dict = do
    let possibilities = filterByPuzzleLetters puzzle $
                        filterByGuessedLetters guessed $
                        filterByLength puzzle $
                        dict
    mapM_ putStrLn possibilities

filterByLength :: String -> [String] -> [String]
filterByLength puzzle dict = filter (\w -> length w == length puzzle) dict

filterByGuessedLetters :: [Char] -> [String] -> [String]
filterByGuessedLetters guessed dict = filter (\w -> not $ any (\c -> c `elem` guessed) w) dict

filterByPuzzleLetters :: String -> [String] -> [String]
filterByPuzzleLetters [] dict     = dict
filterByPuzzleLetters (x:xs) dict = filterByPuzzleLetters xs $ filterWords dict
    where filterWords dict = filter criteria dict
          criteria         = (\w -> x == '_' || x == head (drop (length w - length (x:xs)) w))

printHelp :: IO ()
printHelp = do
    prog <- getProgName
    putStr $ "Usage: cat words.txt | " ++ prog ++ " <puzzle> <letters>\n" ++
             "\n" ++    
             "Options:\n" ++
             "  <puzzle>  Word being guessed.\n" ++
             "             * Only letters allowed.\n" ++
             "             * Use underscore to indicate unknown letters.\n" ++
             "  <letters> Letters known not to be in the puzzle word.\n" ++
             "             * Only letters allowed.\n" ++             
             "\n" ++
             "This program solves the game of hangman. It reads a list of words from the\n" ++
             "standard input and tries to solve the <puzzle> word, ignoring the words\n" ++
             "containing any characters in <letters>.\n" ++
             "\n" ++
             "Example:\n" ++
             "  $ cat words.txt | " ++ prog ++ " h__se aimn\n" ++
             "  hesse\n" ++
             "  house\n" ++
             "  horse\n" ++
             "  house\n" ++
             "\n" ++
             "Project page: http://github.com/LeandroLovisolo/hangman\n" ++
             "      Author: Leandro Lovisolo <leandro@leandro.me>\n"
