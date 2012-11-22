module Stackage.Util where

import           Control.Monad        (when)
import qualified Data.Map             as Map
import qualified Data.Set             as Set
import           Data.Version         (showVersion)
import           Distribution.Version (thisVersion)
import           Stackage.Types
import           System.Directory     (doesDirectoryExist,
                                       removeDirectoryRecursive)

identsToRanges :: Set PackageIdentifier -> Map PackageName VersionRange
identsToRanges =
    Map.unions . map go . Set.toList
  where
    go (PackageIdentifier package version) = Map.singleton package $ thisVersion version

packageVersionString :: (PackageName, Version) -> String
packageVersionString (PackageName p, v) = concat [p, "-", showVersion v]

rm_r :: FilePath -> IO ()
rm_r fp = do
    exists <- doesDirectoryExist fp
    when exists $ removeDirectoryRecursive fp